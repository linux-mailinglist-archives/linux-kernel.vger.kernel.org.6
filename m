Return-Path: <linux-kernel+bounces-357153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52814996C92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EE01C2131C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F6E1991CB;
	Wed,  9 Oct 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgqvtNTg"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF738DE5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481636; cv=none; b=Mfm/jrgl+taBiaW+O2zyVAHE9EEJ1GyPwBV/y+YS2K/HkzGj8sD606SsT+a/m4oX3xvcsTqHnBEtGnZh6eRQt0clhwVvCihdYrHdZ4VUlFv2yA/PAR8aKu2k60eQSMsYtTf9wyTNZ08JnRNeyqEpezxN9kUpLfArKJ9/N3ywLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481636; c=relaxed/simple;
	bh=fVS6oJHlmHK7fYXH2pl32/lczZRzto/jrZKdnYE7GRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m24am7AyXY8lbbqaXCW0k6KWCg8tj7/6Z3s+B8/DZY5r8kjr7FKNaeuRxuhiXZ16WzhnuaCcoyIFGhZCpLRmhhWSgxcQ+gngCofThvyXXqZUZmFjsa1647IcgGlLamee+LfCPvNB5rAHaySV++2LuMPUdR+/ZsItUQpBf2WyNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HgqvtNTg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a994ecf79e7so94819666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728481633; x=1729086433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txQkDRS98qxQSlLjIHl1ZL3viMPBW7fCCoQ6NND/4GI=;
        b=HgqvtNTg+tHSfs9eAgQILA1uHx7SVbCd/AyTao3awzh7qcKMlJo7l8higrxljXoKJs
         GCHhKoDHySmdHJQSDu3c3woI7nHLUFq0SPfpSbVKOtSgqOuRts3PLrskcyam3V5GibMZ
         5anbJZgb3QbUoICffQUNbMaKtWn7WZSC2RSv7Tx93wdeALlQkuLCnRPV4E0efCI0mxK0
         1Ih+hbLyTjz1WqVypk489yxO4AlCR+msK8eXBO4LL7fQIOyWdZoyIMjlffNNSvzXN/Ke
         YHCZcvBf6h3GRK3rrKUE5dwfBcUlBXA+KPOd3CmyA4yrJvSeMZEtTrzBadi41R93I6bh
         RZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481633; x=1729086433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txQkDRS98qxQSlLjIHl1ZL3viMPBW7fCCoQ6NND/4GI=;
        b=R3WAOtNMrFbcbZatEKt/sq4QyfZ9QSJqfe8vqswIjtBX5dAfbTTcoKfLb6Uk1xzXm0
         i7iNQu7frJoBaiLtKQkNfFAifM/FkfdmzfQl0tHrj7GLczQo+TG9ukZnWA3Z//d/ceNc
         DkUXg9oaeAe9ORAgOHu4FbIlz7xAQ2mGhB56iooI+trMnoZGCi63pIrsNtBvkL9sIf3e
         Q9s8MtfyAfzENGqM2ZdXmkhnnvXgx0rM4Q8cMSa+hz/CufqQZAN+gr4FWmWRNkyGzfLT
         dIIVV0M4aj99wDI62pwDnX4u2PzdUptACGx+4lu1O+v61Lidc6OzESvz/53m9vVQAAcF
         5lZw==
X-Forwarded-Encrypted: i=1; AJvYcCUjZNfTbr3U2Fcyf1B2iOztutGD2DosrhnewxyH3xL8xQFmWP3/zUngrN3TvW9ClqCqdJcQXh84Ol6hnTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVgXc1LRn4YpA/mxbVFO3EW4GYvx4QfPhBKiJK0ow4pbau9Ui
	ibfAzYLC2wIt2UnLnvfaAQr6BXPaYCMsDjizj0CsPYaEB4DjhkeH1ufjwscdV60=
X-Google-Smtp-Source: AGHT+IFkWiknZr5mm3FCX6LuZw6eRJb1JJkxWWCDxW/CnP8EG2UoaocNNAuDZ7WJQ9/IeyPs62+vKQ==
X-Received: by 2002:a17:906:d7d1:b0:a90:41a5:bb58 with SMTP id a640c23a62f3a-a998d19eb5amr227845266b.16.1728481633056;
        Wed, 09 Oct 2024 06:47:13 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f4b91aesm462581466b.194.2024.10.09.06.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:47:12 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:47:10 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee@kernel.org>
Cc: linux@treblig.org, jingoohan1@gmail.com, hdegoede@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: Remove notifier
Message-ID: <20241009134710.GA16179@aspen.lan>
References: <20240919232758.639925-1-linux@treblig.org>
 <ZvKgo8RUImafDRPE@phenom.ffwll.local>
 <20241009102230.GC276481@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009102230.GC276481@google.com>

On Wed, Oct 09, 2024 at 11:22:30AM +0100, Lee Jones wrote:
> On Tue, 24 Sep 2024, Simona Vetter wrote:
>
> > On Fri, Sep 20, 2024 at 12:27:58AM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > backlight_register_notifier and backlight_unregister_notifier have
> > > been unused since
> > >   commit 6cb634d0dc85 ("ACPI: video: Remove code to unregister acpi_video
> > > backlight when a native backlight registers")
> > >
> > > With those not being called, it means that the backlight_notifier
> > > list is always empty.
> > >
> > > Remove the functions, the list itself and the enum used in the
> > > notifications.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >
> > Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
> >
> > I think Lee Jones or Daniel Thompson will pick this up.
>
> I will pick this up with Daniel's review.

Thanks for the patch... sorry for the delay. I just bumped this up my
TODO list a little ;-)

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

