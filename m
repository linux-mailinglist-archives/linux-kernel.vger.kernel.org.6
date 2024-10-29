Return-Path: <linux-kernel+bounces-387052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A09B4B30
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D61B2351C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3A8206961;
	Tue, 29 Oct 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wb4LEH2G"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD120695E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209661; cv=none; b=KccBw1Wk1Dlk79x+VZvkbhTgjIkfh7DEzonb877EnN9tsvxUF8+Ie0KQPHYv3a0AZxqg/KHuFFElAA2QjymqQjfzqS6MYa3xxIbVEb6zp0ZM0YSoUPKRKVe73CoXZyKEQuvsEJGCzpTs97BTx25NiTTDPzj9vgvBscpQ2e0AAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209661; c=relaxed/simple;
	bh=MuX46C0b0u91A82k45hWka6IQnP6qDFX7xp0m0U0xog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ/RbiUjdaNNDJpCvB1K1vsWa8Dw8i3qqKLkLP41nkhzSqLISmk5jI6tb1jjB2gr1y/PaYLEgwc2fsXFlYhjXjUuHeCFmcznSOUlOwRda42BtlsjNW+xKfF2B7+RAo83dSBkwE66TGt1HDBBTszAlSLlJ93RedFu9M9711yojkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wb4LEH2G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso50235595e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730209658; x=1730814458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnilKf+1LggrXw/pxXpB+USKjynDFjlh1WwCMDATiQE=;
        b=wb4LEH2GXw8U+WcPtMdDOIUs7P62k6Y4kv+fJKeyZkY/mE0arHNR0b63r33KD3XeYT
         ID9SjMD1uCn4EuoJhqWtE64sIPBwIlKfrJpoWRx8QraAhTnnpfz7AhGlW8GR5+QA+LC6
         ednE6xLIuM10TmOKfd5TS+ILBM8L3x0wg+pDKTNJq5hiBf9P00bLsPbu2KjIpraeT+RJ
         Sy4146qdGZocP2yk1Yi3OKD1ME59/+IE8Fb7RMcIQbHHFBKHIZ3uRbRVF4VSLxLve5es
         8PKE37WkaQbzcPdYjz/yOIX1Ctl1aAILHtxa6UfkfMUnQkbLQX46YLgU1Hb5zShUcx7B
         +hPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209658; x=1730814458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnilKf+1LggrXw/pxXpB+USKjynDFjlh1WwCMDATiQE=;
        b=WQHQr1eOGXww+x6jcfhLnyDtfYBx7AFWIloRpgckckxbwVgMUIT6dvKCKjWYES1LTD
         4FKzmuWoYyAqdXf17COp1gEnm4AGIoiKub9SuyAGPquw9f6lU7L0uZoESubw+iB4zbTQ
         WO8AYk0RBhc/1Yo6H0TVWSVH7/PuxL3Wj5Zy3QDDVW6cL8H7UJrzXbndhhLoRLpdufTV
         Vc2x3MTxCnn0jFX+hoaOQU1gNX/gaEOe35qu1XAqSgpn5j4C0M6gN7X4WZfhxkMCevqc
         tTASuhywKvGq6royt8gHW0jZZ2B7Kqw2w9VTRC31Ze+VJIIZelfxYa/ojIuc/zTzwC1E
         DE6g==
X-Forwarded-Encrypted: i=1; AJvYcCXj1VFQ0lLym58EvzfeHnfPzFJSmpprSZlVARUBnwb0QWqjNb8byoEMqcaHaV8+jqUveiucWIbVeOYNVoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Puii9YU6YCxQJXx+Ev5ej4oBJJHtcczLvnNnhKdppypnNAbj
	ifia6jifS46Qt4Q+oQBo8vnpiYfoYUAi5x46LTKFavqDozwgjY2PIu/JiX+80g==
X-Google-Smtp-Source: AGHT+IFRicCdvu+GXyC4D+ImhbhvYd6aX8bPfpuSw0QRQAOpKsrjXWD7uCi3UbUTKpUo37D4ocP8/Q==
X-Received: by 2002:a05:600c:3b94:b0:431:4e3f:9dee with SMTP id 5b1f17b1804b1-4319ac7409amr89860875e9.4.1730209657614;
        Tue, 29 Oct 2024 06:47:37 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm12652018f8f.70.2024.10.29.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:47:37 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:47:34 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
Message-ID: <ZyDndtgj5vKo-wvB@google.com>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
 <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>
 <ZyDlAd-Z26wnhZK5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyDlAd-Z26wnhZK5@google.com>

On Tue, Oct 29, 2024 at 01:37:09PM +0000, Aleksei Vetrov wrote:
> On Mon, Oct 28, 2024 at 04:58:58PM -0600, Gustavo A. R. Silva wrote:
> > 
> > As in the previous patch, this should include the following tag
> > (and probably CC stable):
> > 
> > Fixes: 80e698e2df5b ("ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list with __counted_by")
> 
> Thank you very much for this suggestion! I didn't understand how Fixes
> tag works until your comment, but I've just read about Linux stable
> process and it makes sense now.
> 
> Sent v2.

Actually, my reply above meant to be for the nl80211 fix
(https://lore.kernel.org/r/20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com).

For this fix I couldn't send v2, because it has been already applied by
Mark Brown. Guess I would need to send a separate message to the stable
team asking them to pick this patch from git.

--
Aleksei Vetrov

