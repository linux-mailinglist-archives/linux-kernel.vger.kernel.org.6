Return-Path: <linux-kernel+bounces-565935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D26A67145
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4303B8907
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A8207E11;
	Tue, 18 Mar 2025 10:28:44 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFB2040B3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293724; cv=none; b=Eo+yW0SKi/9zgORHBxTWtkw5pYidB9GakL7lLgOvV1QR2gW82cD+J1802AJPj2JIzzkvEot3PiJSLnRNO/3c0jHAzPUZTQt34MhYtX8+n6BgzN84X4r9OUcNGJmn8Fe/P5teuk7itFc5GPW+rbBJIYMNyFVpOXE76Cb0sbhbWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293724; c=relaxed/simple;
	bh=0Yf8zwe0iIiSKI0Dg2hD7OmFQpt7e+kC2AcWFL83mwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS8igThbbNdqapZhP8oeAXRMIRozfAE+5TSHNu69kRNE5f8u9mIj31P1JD+L6YwdoTh1sBmf4MuDv6WzpuYiIbLACHDJyD121BnMup9hofDtAhtInF5Ok4+75K134+px7kN4anogSXRU7gH8fMXFm6S2g8Av18WCSP7IkJ82uHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225489a0ae6so152875ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293721; x=1742898521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM+okc81SddqYQR5Qb68dWyTT/KjxhqC4j719LC3UJ8=;
        b=C/4mrGpnvcqL3Kx/y58dvFNsYcVEfA3On1rU/xzoezPcBnt/jGeLP9/s/MwWc9yc1t
         /6xFZgcqPDcfnDCUyitlHT6Edz/S2cOAGs8JDLCHoYDTSzfKTIMUYhGKHHsKizePxjmK
         ntSE1YPJBLKy0ZSuBYwyY8N/htFy1rNP+Z2P2O9LbX59HL74Jn8KDzUqnSGfcCXWa1S+
         sH1s+6y08L020imDcmASJzRXVOAwsGP/61DY3LItTmGqW2UxG5FsbgP9pDDUb93jG3oc
         h7FsvYM7ieJl1pqHbjvJ0nLvFdKRz1SxDQ/FG+aLGdIR7luMWi8fUFw+pTrATuT2J1QU
         lY0A==
X-Forwarded-Encrypted: i=1; AJvYcCUwn0cJtTj28WE9LHPS2IkqR6dZCnSFRgcaP6Xnc+fvbOtRuZjf1/3E6yu1qCIc+FyxCR1uXpm2sxqDmJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1oE6DzbqLhTwQpINJEetxj/PeL5450fPVOZUCq9mbcDJET2ri
	iqNTLLnUxcXn1orK7p3bsCYCctwcUmKKAufrLBVnoiFTxqFYAoT1ZDcnbso+TQ==
X-Gm-Gg: ASbGncszSUgWNKHVhydjAxVvpFnwhdZ9qLK0HQAfFQoGklkbPL3VLkF8WlAxJmqe+6U
	anN7j3TokEIaKPVDDWBLzzmsasDuuBQFB7Fu3KazJCLUvGtK5dA3cjD2Ku4CJCDPr2u+et7Cj3j
	lYzCDBjm2XHNfrqEd8Do/nVOB5VABRUEeIZnvHh8CNLtGR1YG+wGvt3cXJxMbGTvbfdQjSJrOQt
	MeJyW+JAebIN5vZZNi9r4NRZlhs1Q2iEOARfee3KPE+X4/B1/oKCMWMHCpbyUZCpDwFqmU5dtOn
	3Dy8vQCus1BT1dKRSN2DmDQPLL0IfQVy3/dRXe6MHG48Bw==
X-Google-Smtp-Source: AGHT+IGKc8EaZI3unlc+kVdriOoL1O0l9vdYG/4SJdDspSPx+oktmGGKkLOFcJKRAjb8ZjB5EId3xw==
X-Received: by 2002:a17:902:ef43:b0:215:8232:5596 with SMTP id d9443c01a7336-22630eecac6mr1808115ad.16.1742293720753;
        Tue, 18 Mar 2025 03:28:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a770:ff91:7d61:7179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5da2sm90801825ad.254.2025.03.18.03.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:28:40 -0700 (PDT)
Date: Tue, 18 Mar 2025 19:28:32 +0900
From: Hidenori Kobayashi <hidenorik@chromium.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: vivid: Add more webcam resolutions
Message-ID: <4gfphzokeqm4rx2ggxz2pq4wekbuqofpzrfdasafuk3h5xzlip@xwbc6jnd3mdj>
References: <20250314-vivid-fix-twice-v2-0-dcfca4053704@chromium.org>
 <20250314-vivid-fix-twice-v2-2-dcfca4053704@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-vivid-fix-twice-v2-2-dcfca4053704@chromium.org>

Re-sending in proper plain text. Sorry, please discard the previous one.

On Fri, Mar 14, 2025 at 12:39:41PM +0000, Ricardo Ribalda wrote:
> Add 3 more common resolution for webcams. This is required to increase
> the test coverage of unit tests based on vivid.
> 
> Co-developed-by: Hidenori Kobayashi <hidenorik@chromium.org>
> Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/test-drivers/vivid/vivid-vid-cap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> index 623ba1e5e54791c0ac62aa2f0fcc3dcd444c873a..df726961222be874c39d19e1fb457bd816ab45fd 100644
> --- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> +++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> @@ -25,9 +25,12 @@
>  /* Sizes must be in increasing order */
>  static const struct v4l2_frmsize_discrete webcam_sizes[] = {
>  	{  320, 180 },
> +	{  320, 240 },
>  	{  640, 360 },
>  	{  640, 480 },
>  	{ 1280, 720 },
> +	{ 1280, 960 },
> +	{ 1600, 1200 },
>  	{ 1920, 1080 },
>  	{ 3840, 2160 },
>  };
> 
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 

Tested-by: Hidenori Kobayashi <hidenorik@chromium.org> # v4l2-compliance,
v4l2-ctl --list-formats-ext


