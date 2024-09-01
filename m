Return-Path: <linux-kernel+bounces-310186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBB49675F9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D433B21421
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3244715FA7E;
	Sun,  1 Sep 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Asia66Kb"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D141465B8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725188254; cv=none; b=do0TTVG/vt1knQ1ln0vEMc0FsSBSLkbb1Pg6cVBt1Mw3SldBFVx4kpGGHwO3PNC6z7ierwiaEajgdLWil7d0Dpz4W023wT7WfQUwj+yC7QE6ValSJXIaPuTQ3lIT+xvEsPaEWHjANr7VgktbsziPZ8mUAThL0sO8LYDXxtxyQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725188254; c=relaxed/simple;
	bh=1RX+vRj2WDBZgEHf/s25URGTZFaFeYvaeduaGZ5oaUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdbCh8DNbOs9j1EWZUUC2lIGyAqJ9KBcYLNWvesKCgC1S/37CQ0NXlrtJGaOzAX7DC6N8E/MbZ4J4KfzW688ri97furoJsWf9iCuJcaq3/NKqc6K8C6fypPhlZDV7f+4IOMpqamMI0JX3x6L+C3dpgLlUFdKYCXamsV6f+CfTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Asia66Kb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f50966c469so36807251fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725188251; x=1725793051; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ECaoGYWyIBNbrv3AMXpRW3HLCAEHZsevcmAfdfVZ7K0=;
        b=Asia66KbDEWfbLt2LQSeZATiwdOXhCPCF94s0o3+T4Weef88GT/Wr+i9v4252eQSVQ
         vBC+HpLknOu8XoVavRqy39/5jjG2K2CnMmmqBJlbh6u257vJUvQhp4p5eP4h71eZykYx
         q08A8aYqK8CbOCiPjGUHnYezfdyEC73Vnz5cKiLxEhl7HZW7lUH6DPW/9qO/lLfMIOkz
         3j0s/EThqnX5I8tC65MKjVwGgcdJp4XkYgQcOr0h3m09xR613h4W7XvWogVvn37y8U4H
         cpO5sN+1IYvKMFZ/o3lz0pTyn/+gVweXJmZ6ZlwFIKK8e8Lg3OczL8UqxRtvL+3Kjus9
         L4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725188251; x=1725793051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECaoGYWyIBNbrv3AMXpRW3HLCAEHZsevcmAfdfVZ7K0=;
        b=HIep1Q31cGXsiuKjfnaEUr94raPFBBVuMLdUgokZLW4pYeI1V2UNmZjqIl0yZtIBmH
         45+Jx5KPaFFtV9Vd5/njpUwCzWA9Xk3em4odms7DkfLPoLATQBi4n2OyVREkX/9EL5Ix
         XJExNHIxeiuWZ/aItqNhgS3YY2slc9nZpqrFJw8jcxo5y6Qgipf4OW2eEwqrY1/qdjJi
         fNOvRAax23GKUhXHI7WDnRJXrhOEF8NIJC6unAQPbH2TfLRrVV+NjXcI6y23Rie4eh80
         ZCR2T4oDGUYcAMCc+mF7JCeNiQsEutQOEZoZj3IW4Alpg+9WD02h0oBV8EMqgzaTowd5
         /1aw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ALcp+Wr5OP4Gx5ph/FUvqZsDFyQYD33VF1HGe3aQDFZz+Q3hD0V1AyDFcExW77nAb3N9+PNxfKBZk2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2i+9KzG3wkX23JHYoiQjq/XkFOPeNFpK1gt0sG+8kzJfs7Me9
	IGNkkqsFwKC1SeKly/x39Ieabrhc5NnnUfp5PCceRMfOSq87Lc6yDDZ0b6lJfA==
X-Google-Smtp-Source: AGHT+IHFmJuVRNjfjHOO+1xHeRCV2FbY7iA4y1QwPbq98Xs5aUU94MEEwJfZWZOVY07dN7YvGJCwbw==
X-Received: by 2002:a2e:4e19:0:b0:2f5:11f6:1b2c with SMTP id 38308e7fff4ca-2f629066565mr18624431fa.23.1725188250626;
        Sun, 01 Sep 2024 03:57:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:c40b:3968:38f9:d59b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f003b1sm13717311fa.33.2024.09.01.03.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 03:57:29 -0700 (PDT)
Date: Sun, 1 Sep 2024 12:57:25 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZtRIla5pCqlMIKvN@google.com>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqlDuIj_nMVXhYou@x1>

On Tue, Jul 30, 2024 at 04:49:12PM -0300, Arnaldo Carvalho de Melo wrote:
> Unfortunately it clashed with recent patches in the capstone related
> codebase, IIRC Athira's for powerpc data-type profiling.
> 
> […]
> 
> I'll continue processing other patched and eventually try to fix this if
> you're busy,

Hi,

Is there any movement in getting v10 merged? :-) I haven't heard back
since I sent out the rebase.

/* Steinar */

