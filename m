Return-Path: <linux-kernel+bounces-209814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A76C903B38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EEC1F21DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE017BB02;
	Tue, 11 Jun 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gL1IKhVf"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9F114F9EE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106992; cv=none; b=sjBbeqcdyvLbfs4bvUcARVTYcZbS3wk3WMOow9qoSTqZ19paa331vk4nbOUQ4q+I2JX3VGuBvKcx/br/q20+eT/Xn7S5RopnqR40p8BtOSxm7A+U/qes7/cmZ7vUJVjikFuCCuuBCX6Ta6sWoEb4EfJi/4+7UcfZooYJ+SDLi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106992; c=relaxed/simple;
	bh=5/w1fxjjLpUaMAtqSgUdQY44foBz0hFdDn8lECfTnxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O4mOdxJkrHk0+Zr6/wwti1GwXk4oIoQJWAWKEFEgXqZVvFPB5LYsj7/yobQ0/QvJ424eXXB7+jRFJVAzKB2ikhQ5o75c0Jjj/0l69veapPMPR5omG08ISRlvUbw3tKyZovTlE74wHJFcg9pfNlzY2ev/gzYb9He+fPLS4Ztsm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gL1IKhVf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so3099883a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718106989; x=1718711789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOddwMpzJW/6gs70n9pWk7Fv9UPxutUQ3E6BTp5E4Gc=;
        b=gL1IKhVf1434YxCzyjM83ISTNUSfhG78ftSMQzNQq5M0G0YJOMQrLldmBD3yH//dkH
         XWckLOV1x7t+pNfDkd5AQEwbD3CojK6r3bc3XeebmYyOOp1M87VjQh7/jtakorpZ2HaW
         KtujXfu4jFDgHoxp5yMj37HFxhXt1dTIh26XhA5UKUuBe7KITXnr/gu2eXNqYBAHs7sC
         w1OE/JxMQa047JtANSHod2oVZnPCg0FJFX6r5a46KwyWMvPeII1T9N4AlLDSD2+enPF0
         WUEtX828eq8q1UGrRbOtbYpqs2ut/MVl6S4Rol3CJSqVd9oJQPYRJ+i54aZp5ws86I/Y
         6ELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106989; x=1718711789;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOddwMpzJW/6gs70n9pWk7Fv9UPxutUQ3E6BTp5E4Gc=;
        b=quVXFdqBxX33aXSnmY+x1GzJeeS8LZM/QEoor2yX9XBCDWiKYWbdmPySpUGWJV3UAv
         0jaR1JNX32/i2NpLO5tHDUOj+1BXgq4suXLh2VqKjAz8UvY+nTVY6CIQewww7/29/QTb
         p0IHg9ob1/ZSIbL6eUvxt1h7YuEUYXTn1a0C9DVtItzICzIxFIXDOA2V/eaVzjGS6njm
         5vW/JJf/CGd9Hxk66hdcC9DtnoO/qJh/CQufp/eT52TBLr2k/IdSNpCQ3mz6k7NZlkDW
         PK1QcgM+9D7aubKRzGgUacEp5tCT30RayDKhnoscNrQ78J80bmfNzc7fH1EUFQ3a8MRE
         fFEw==
X-Forwarded-Encrypted: i=1; AJvYcCU1z1/Hh2SB3gZiu7qOuEzTwEXQud1TamyNwucpP1P1B/9AssDY7IJ6DxvIDy5kAkHDxURu49TsqQTka3NUoRi0iY2Dn5aGy6I3fXeS
X-Gm-Message-State: AOJu0Yx7dDDVSofhD3TPsDabGmfvCuBQivS/+09KlBW1/JUdtGeDuBpJ
	KzNk11MAjBP584y1Zlu7xEilFOBma6rvZ14uDNwtDK7dg5+TJGZiNTTCIIDHoNZ0BNnyTXzgzBi
	p93s=
X-Google-Smtp-Source: AGHT+IFP4m28hl48ttcEQ8P2FYios026SYXaYffz8UvYZieOHmYVy4+wRns1OxyElbht8qv1wrV7rA==
X-Received: by 2002:a50:d602:0:b0:57c:84fe:1acf with SMTP id 4fb4d7f45d1cf-57c84fe1b0fmr2543110a12.17.1718106989655;
        Tue, 11 Jun 2024 04:56:29 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c960e677asm851632a12.62.2024.06.11.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:56:28 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-arm-msm@vger.kernel.org, Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
In-Reply-To: <20240611103442.27198-1-quic_ekangupt@quicinc.com>
References: <20240611103442.27198-1-quic_ekangupt@quicinc.com>
Subject: Re: (subset) [PATCH v5 0/7] Add missing fixes to FastRPC driver
Message-Id: <171810698822.68529.11340532030579148495.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 12:56:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 11 Jun 2024 16:04:33 +0530, Ekansh Gupta wrote:
> This patch series adds the listed bug fixes that have been missing
> in upstream fastRPC driver.
> - Fix DSP capabilities request.
> - Fix issues in audio daemon attach operation.
> - Restrict untrusted app to attach to privilegeded PD.
> 
> Changes in v2:
> - Added separate patch to add newlines in dev_err.
> - Added a bug fix in fastrpc capability function.
> - Added a new patch to save and restore interrupted context.
> - Fixed config dependency for PDR support.
> 
> [...]

Applied, thanks!

[1/7] misc: fastrpc: Add missing dev_err newlines
      commit: 372eb825c2040b81b6c20b8ff662a6a551f236f9

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


