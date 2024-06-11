Return-Path: <linux-kernel+bounces-209813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CE3903B36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96467287B36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6D17997D;
	Tue, 11 Jun 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="noh2At1L"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A614F9E4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106991; cv=none; b=WuH8H6GBw1RHnbPG1uu9MVzsuVMDZ/HewR21ly2Tv1xhEs6SfyKSz7uLh4QNdmkzTExFcwJq7iPk99/TV4ZQZEyenPpygRln7mGBCmA3nkY8re+2qskoGIH/Thsowzh5LsURX1Z3UHpwunQx9FXLa4/isT7BZV7yfcrICVPaG4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106991; c=relaxed/simple;
	bh=b60H6iwQtLtwbEdqhPNPN3MAzTHsTvZVsKR6YgqVkjA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LyPI91NlJOpKih5T/KgPsDKGvhsQ2tSI35duEpri/gcmxuvfE0D8CROznaaSGhZ4/D5als2ajVSi4vGl8PIQ5/W8k+PHB263kEkxEd7xXY+sXXmr+SqYTia4IU2H+oVn2ke7PuBGeiThS/TtajpCi9J1+GkS3O+dJOEZM+g/PKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=noh2At1L; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c681dd692so4170216a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718106988; x=1718711788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOQGwGYGp7iCwEU2oaPnwQ54CBf6jzk5PtxO4hXtPkc=;
        b=noh2At1LvAbL0zqfrvbN+2NeMnD++m0EdCxPyuILI1yNz+kECtFHqSPFKyDmLBEKqA
         FU74uAe5ecLU3AM1kakbKQIR4++0U8uk3sYl7/61Cgni+HX/ebhoPaBYX8HnQ9sd15Y+
         ciZ1zc22FLV/hLL7WsEDxFn135YHWpbwD+n0elOT9CL3EkDgYCMVnEgn+MCV0IbYl75E
         rDn9b9eAuSuSRrxN+7n4rObGc34jpR//RCTX+0PzF4MyfkSq5JH3/LsxYKeyVrTiHn5Y
         NSdSAUfsRoxv3fqwWzx6Sf82nZi3D6NmKVdw6MVsOuwIuyTf3AQmoPnzgCnuW0aiel9w
         quCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106988; x=1718711788;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOQGwGYGp7iCwEU2oaPnwQ54CBf6jzk5PtxO4hXtPkc=;
        b=XShyuo/fvCyrA8Bc8PSTVQq1G8B6rrL26OmyeV0BB72ENPbpjv2bvT+H25ew1ZHWC4
         9AtyHwPDG4hiSAIxAzGFORmCGz7QzeQnnYSRYhCvp0kzn0Cgd04GfKZhtk4y09nbtMeL
         TyGqOuGNQePvw+Dza4Y3SfJtB7rxicyZ//DO9MtX9kTOYf3Ty9/XUzJXvPdYHhGNemAe
         HQnd121vVM7zyWQoGiyrE8l/Oa5GM7REQoB/3ZJ2U0QfdqaIaIIMfN/8roqZV1kKmOca
         WC7cFaSZkZqEgqtdmdFLlI7BtG4E8OABmIHcuM4tguu0OHDlTxCCepTfMHn2u993tx26
         IC7A==
X-Forwarded-Encrypted: i=1; AJvYcCWR3wKOi0vOOPPFevub9emxiYBgUgO0AV2D4VgC+b0kBzXMpEhX3fxZ/0rpBL5d6PUqVvka2TCHCnUiLNVvvCw7EjG3YFPUE/opRRre
X-Gm-Message-State: AOJu0YzhbGxFHDddab2CSPfagzXspE3M/q+4A7GsV8SiA+Cjp5pBy5xN
	CE0sOrrgyqissihsUb3lz2mK31UG2u/yx4OaozNFQ1EjAjQ3tSUoxvUEud2L8FU=
X-Google-Smtp-Source: AGHT+IFA0bok5KmXR8AeW4Ak8pvAute/Efj9rz4I1LbxhP9Hnz5VuBZNyHDGWWy/+jzYmGb2CRlpmw==
X-Received: by 2002:a50:9f89:0:b0:57c:7fc1:5d57 with SMTP id 4fb4d7f45d1cf-57c7fc15e88mr3427610a12.7.1718106988021;
        Tue, 11 Jun 2024 04:56:28 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c960e677asm851632a12.62.2024.06.11.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:56:27 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-arm-msm@vger.kernel.org, Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
In-Reply-To: <20240528112956.5979-1-quic_ekangupt@quicinc.com>
References: <20240528112956.5979-1-quic_ekangupt@quicinc.com>
Subject: Re: (subset) [PATCH v2 0/8] Add missing features to FastRPC driver
Message-Id: <171810698723.68529.3654404056336837599.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 12:56:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 28 May 2024 16:59:46 +0530, Ekansh Gupta wrote:
> This patch series adds the listed features that have been missing
> in upstream fastRPC driver.
> - Add missing bug fixes.
> - Add support for interrupted context.
> - Add static PD restart support for audio and sensors PD using
>   PDR framework.
> - Redesign and improve remote heap management.
> - Add change to support unsigned PD. Unsigned PD can be enabled
>   using userspace API:
>   https://git.codelinaro.org/linaro/qcomlt/fastrpc/-/blob/master/src/fastrpc_apps_user.c?ref_type=heads#L1173
> - Add check for untrusted applications and allow trusted processed to
>   offload to system unsigned PD.
>   https://git.codelinaro.org/srinivas.kandagatla/fastrpc-qcom/-/commit/dfd073681d6a02efa080c5066546ff80c609668a
> 
> [...]

Applied, thanks!

[1/8] misc: fastrpc: Add missing dev_err newlines
      commit: 372eb825c2040b81b6c20b8ff662a6a551f236f9

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


