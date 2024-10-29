Return-Path: <linux-kernel+bounces-387036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C549B4B09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904D41F23C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEAE206078;
	Tue, 29 Oct 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhcgfcNc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF600205ADA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209032; cv=none; b=S6cnt86ME0ybT3sLvEr0WSkTthP70nhj1eEeawFz0BTHAZ56ie93CfIkrjrPWTf+AZIHkju0yrX4+jAvSDxEHYLNkah5MGNEwzfDT+ouzNgD1IgryI6NjXDIW+b4kXRqQ0DoUJf6ZRoVkUOrXsCa0z0aNgpqQbwWTRxmZ9yw/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209032; c=relaxed/simple;
	bh=Buf8pFNcSxiAlM8W+Pmp65ui4MzMokidkAZZi2O1+KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ5wa8aXW8zsxeWyo3YJ53P2+7i6Lzs6cOzpzmNX03D1GmPAJCyxoLcbkpGupjuofBAEZPrwn4ehw7ZpTfxv7n6keoj6SzjxkDVHmFO0czmkVCsBHujDDcFC1oFEUZZwCn8OMvPrLUfYGhE/1mgSStL6/dM9fVMGs3WFK0ZE3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhcgfcNc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4316cce103dso71654705e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730209029; x=1730813829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hh5EOww19pBRNBFKTyF3PKTcC/X16iO+VdPl+8FqIg=;
        b=MhcgfcNcOV8ezrW51NwU4HHW4VeJ4XEonZP/yxDQBAb83GILs7iVmznfErZDi/xnnl
         R4LfJW+jR92RI+Z6Gujc+KBn10A22K8rHWpe8uTu7E4ppJqHswBT9Ys5gJHYPR8kM7Rd
         hN09K4r10yQe8suVmc4in8Qzqj2se+ul1lbh4iCbDqW6FtvnKW0TpxSj/A0q5gtLy8qw
         02yvQ+h2L1VHZmmMeMmow6DmquEITuw7r6VG1XBGznWNCCMK7dnIRrjrS4pARbhl/ZXS
         e25/HjkJVL4p9z/w/n00plA0KnoGw2+8QU5l9+PSvuhMz2JWwjdJXAbBf25I6DXs+Qo9
         of9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209029; x=1730813829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hh5EOww19pBRNBFKTyF3PKTcC/X16iO+VdPl+8FqIg=;
        b=Leupu8lZAmy6fa7JTbKPPEoM7Ursko48h8IBcrfcjf3XbWTMiEW6w3ujVec4I+yNyX
         Yy7RiaTlxuyCjwYHZYxZZ1E0V2k28+q8BNBzouQqU3vm0WhOC34e6VlkT92rbVINL0hL
         8QHFQVV8ChOGqn6eiF0B6TVZ+jsgbOhUrKA3zPT26z6P9hUQVvEs6Fy8wL7CA7TbjHwA
         OHXHi3Z5duUJkh0ks2xDk/7fk3jdoO0WPwzRubStltBTtAhdxCABzN2MWPSPNeKAgijn
         tkoEilfPXq8DKxOT+DVAPsK8Ro8KpR/9a1hlvUb9oidaWthtGU0YpH+dKL/esNjdorTj
         9Rag==
X-Forwarded-Encrypted: i=1; AJvYcCWr4H8R+bA7EcQAuLx4mdHRAUlFXNreLPcLHcg6kiHIXWun1/XLQ5/wJXgvNoJ/rTGFEewa+yZfzHecAMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYd9NRWDoZwud96yjSngzOKFpOdbH0zrF256aZOT8Hf217S4NI
	BRpDENySzUyEULhPg0XqRRWafmIAEu3GnQFoGx+RJxVyaYDDxIIfDf29Z2F/yw==
X-Google-Smtp-Source: AGHT+IGch4QTQwjJXcvKat0hRtmQ+uBZueGwh+G5DA+m6c5CngK7+kfRgN9RkLc99gGvKiTTqX4E5g==
X-Received: by 2002:adf:e78c:0:b0:37d:2ea4:bfcc with SMTP id ffacd0b85a97d-38061172233mr11529235f8f.13.1730209029164;
        Tue, 29 Oct 2024 06:37:09 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b0ed7bsm12566744f8f.19.2024.10.29.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:37:08 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:37:05 +0000
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
Message-ID: <ZyDlAd-Z26wnhZK5@google.com>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
 <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>

On Mon, Oct 28, 2024 at 04:58:58PM -0600, Gustavo A. R. Silva wrote:
> 
> As in the previous patch, this should include the following tag
> (and probably CC stable):
> 
> Fixes: 80e698e2df5b ("ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list with __counted_by")

Thank you very much for this suggestion! I didn't understand how Fixes
tag works until your comment, but I've just read about Linux stable
process and it makes sense now.

Sent v2.

--
Aleksei Vetrov

