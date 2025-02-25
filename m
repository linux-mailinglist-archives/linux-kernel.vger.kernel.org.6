Return-Path: <linux-kernel+bounces-531283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA07AA43E84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C371C4424CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3602673A5;
	Tue, 25 Feb 2025 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RInhwchU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23F24EF9B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484572; cv=none; b=Mii81FCradsJ6H36B08gaG0JgLu8OVm3RxsZnuRnZ/HmgscctuGH9K57UTWLqAlGZY2uTxVGEuuMviWifRVfVahdWyfXqzNO7sf7Edpxo7T3rMFa36RDAnVJhSNeqcfH6Pu5q8AQTYCfyCrgtNLXstUNGy1hNkfAZju5qZxY2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484572; c=relaxed/simple;
	bh=iWgmiXsLf83OauoL4O+8afLdL8TcN5A77a9qDkmqwtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOTk+7ZQ3IZxmOmVRuh7EhHZOSdHVai2r3oEAfi4GG0ayPQYjCymkzRiLl6ctpn2JxWPYzhsegSrJv3MuoCZwhb+q3MgC/ehhJAeyKo3h/kLWg4eYgHh2oq8NTHGC4ogr2+/rUdka7rZwlLqGz0jpEt04NbqFDSPwPJKnruDOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RInhwchU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1097697966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740484568; x=1741089368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJyPxjFleKuEal7BN10cNxi9EzRWaplUTMZg3DzwJ5g=;
        b=RInhwchUgde91kcg4T8ATu6pV/C0pN1kWSKDmr6UY/E1BdBkOWJtymrpZBhkwhx3+w
         UuiJ1t/WJuIgwm9P+BJRf2pFvcVGuGoPaQUngIw7VRK6D2HtR2hrT/xNOZhL9cxOxiAG
         kwqD3Bm7132T6gCFUhGogBbGz1IU3EYQc1ReNJ9cs9C5Ycumpo15SLnSOAnCpjdmSjjQ
         wRwwkfNHxWnUVUHCtb9um/HT6PWJAG/xDyvtUU8wIf6GnAkra0GOBQNBUVKOpd9ZM+0Y
         l953RmdyQVuoJzETedIMe8uqpCFNTHZONyQw6xHdZvBWRzQOatwEb6BTMDMpswx9Ofx+
         ca5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484568; x=1741089368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJyPxjFleKuEal7BN10cNxi9EzRWaplUTMZg3DzwJ5g=;
        b=DlfRd5UnmlkWU8J0UlK/fbHLnaM0tVAmhHUIOqU2c1Qgh9gsfRnFwr7oMcVynr8OwK
         d0HrdUR4NfuA0+nf+/CZX5iX/Syg9l+7I7A/fO59ttTw+7vGQtEOP3LxEPko4WHNllX4
         LxmHnc3gIXbv5MkvBCtX75n0VxvT4BuZjUz8bn9s5vsb5HAPxTlRM1okdlNmixxTaFuF
         4eLh2WDKarNGDqtCosRkcXj/4B/s19wgZD8W1fei/j2gxjfPtXxnJq4k0ctx89VUeJHQ
         TgdsKvF8l7RhD7GoRbsuQ5mBXaH+BIZ70yyKaf+saIkiYceco3IFpTTi4uYhcoXeuQJ+
         51Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWXWdADdkFuI0Q/DfTvseMP4CpIIKDjSeUupd13BRcr3LMwpyb6xuZakr4X//BOJ4FwJpgsAX1jvqxYn8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBdHZtrd5xOgeUVlqqeAPelGyifQCnHmWOvzdd1vcoz7WfUHH
	dQfzrfUeSF+w3trJGE5DCd9IWXRKopW4m4OH6P8sbMJXvM+1rEB1CAb3cclZ1lU=
X-Gm-Gg: ASbGnctNFnF8KbIa/K+b2o+nftrl394vzLtQcrwUSiOMOQVIdCV4qBGPiNgp2dM0qA0
	d/yTk+uMFcd0BqLiemW3OJI3lyKEcrbFoXJelIuCIRjKnaiEU6CMEMfFpDcjeT23qcAQ2XEieUz
	gGZXb1gr3zXQ8rYlaKeUVXW6kWXYiIkl/PGKsixHzZDTbkyF9tb/Rx+rkscaiU2l/v1huWMiNyd
	09ruXvQKJdqTKWOp4+0X9FqjrY9mTLPIfAmzKZc0jIiI6heGcnihCoatmwfhNuFQu5rZydf3c8o
	cQpkH7ARPAbCZHvtbKzK3UcIp9TefXc=
X-Google-Smtp-Source: AGHT+IGtwfDPoI1urGz4W6sWGWt7cIKJRtHke0xAzp1DGA8IEACl7iCkLafu7qlCmJ17Ht/wFJ+uJw==
X-Received: by 2002:a17:906:3290:b0:ab7:b30:42ed with SMTP id a640c23a62f3a-abed0959f38mr253119666b.0.1740484568004;
        Tue, 25 Feb 2025 03:56:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abed2012360sm127195466b.114.2025.02.25.03.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:56:07 -0800 (PST)
Date: Tue, 25 Feb 2025 14:56:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] vgaswitcheroo: Fix error checking in
 vga_switcheroo_register_audio_client()
Message-ID: <121efc5e-1050-476e-8e34-e4db11a4ac11@stanley.mountain>
References: <ae24cd32-1e78-4656-b983-051ed22d86b9@stanley.mountain>
 <87eczn7adi.fsf@intel.com>
 <8e161bf8-70f6-4557-8fa8-81d4bbfab91f@stanley.mountain>
 <87zfia5r0a.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfia5r0a.fsf@intel.com>

On Tue, Feb 25, 2025 at 11:10:29AM +0200, Jani Nikula wrote:
> On Mon, 24 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > On Mon, Feb 24, 2025 at 03:14:33PM +0200, Jani Nikula wrote:
> >> On Wed, 19 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >> > The "id" variable is an enum and in this context it's treated as an
> >> > unsigned int so the error handling can never trigger.  The
> >> > ->get_client_id() functions do not currently return any errors but
> >> > I imagine that if they did, then the intention was to return
> >> > VGA_SWITCHEROO_UNKNOWN_ID on error.  Let's check for both negatives
> >> > and UNKNOWN_ID so we'll catch it either way.
> >> >
> >> > Reported-by: Su Hui <suhui@nfschina.com>
> >> > Closes: https://lore.kernel.org/all/20231026021056.850680-1-suhui@nfschina.com/
> >> > Fixes: 4aaf448fa975 ("vga_switcheroo: set audio client id according to bound GPU id")
> >> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> > ---
> >> >  drivers/gpu/vga/vga_switcheroo.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> >> > index 18f2c92beff8..216fb208eb31 100644
> >> > --- a/drivers/gpu/vga/vga_switcheroo.c
> >> > +++ b/drivers/gpu/vga/vga_switcheroo.c
> >> > @@ -375,7 +375,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
> >> >  	mutex_lock(&vgasr_mutex);
> >> >  	if (vgasr_priv.active) {
> >> >  		id = vgasr_priv.handler->get_client_id(vga_dev);
> >> > -		if (id < 0) {
> >> > +		if ((int)id < 0 || id == VGA_SWITCHEROO_UNKNOWN_ID) {
> >> 
> >> Maybe we want to do something else here... see [1].
> >> 
> >> BR,
> >> Jani.
> >> 
> >> 
> >> [1] https://lore.kernel.org/r/CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com
> >> 
> >
> > I feel like my patch is good enough...  I guess the concern here is that
> > GCC could change enums to something else.  I don't think that's likely as
> > it would break a lot of code.  The other option, which is a good option,
> > is to change the function signature for vgasr_priv.handler->get_client_id()
> > so that we do:
> >
> > 	ret = vgasr_priv.handler->get_client_id(vga_dev, &id);
> > 	if (ret)
> > 		return;
> >
> > That's better code, honestly.  But I can't find motivation enough to do
> > the work.
> 
> The more I look at this, the more bonkers 4aaf448fa975 feels.
> 
> Anyway, I don't think ->get_client_id() hooks should return negative
> error codes, and indeed none of them do. None of them return
> VGA_SWITCHEROO_UNKNOWN_ID either, but that would be a valid return.
> 

Ugh...  Yeah.  The checks should all be the same obviously...


> I suggest only checking for id == VGA_SWITCHEROO_UNKNOWN_ID. And doing
> that in all the places that have that check, there are two more, but
> they assign the return value to an int. So the int ret should be changed
> to enum vga_switcheroo_unknown_id id I think.
> 

I mean the future is hard to predict but it's way more likely that
people will return negative error codes than that they'll return
VGA_SWITCHEROO_UNKNOWN_ID.  To be honest, I'd probably just apply
Su Hui's original patch at this point based on that's how that's what
all the callers essentially do.

https://lore.kernel.org/all/20231026021056.850680-1-suhui@nfschina.com/

Really returning VGA_SWITCHEROO_UNKNOWN_ID is a headache for the callers
because they have to test for it and then return -EINVAL.  It's
non-standard and more complicated than just checking for negative.

Changing it to return int is also slightly frustrating because everything
returns zero but that's more likely the best approach.

regards,
dan carpenter

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 3893e6fc2f03..494df3984c68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -549,12 +549,14 @@ static int amdgpu_atpx_init(void)
  * look up whether we are the integrated or discrete GPU (all asics).
  * Returns the client id.
  */
-static enum vga_switcheroo_client_id amdgpu_atpx_get_client_id(struct pci_dev *pdev)
+static int amdgpu_atpx_get_client_id(struct pci_dev *pdev, enum vga_switcheroo_client_id *id)
 {
 	if (amdgpu_atpx_priv.dhandle == ACPI_HANDLE(&pdev->dev))
-		return VGA_SWITCHEROO_IGD;
+		*id = VGA_SWITCHEROO_IGD;
 	else
-		return VGA_SWITCHEROO_DIS;
+		*id = VGA_SWITCHEROO_DIS;
+
+	return 0;
 }
 
 static const struct vga_switcheroo_handler amdgpu_atpx_handler = {
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 21b56cc7605c..72f3d02779ec 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -192,17 +192,22 @@ static int nouveau_dsm_power_state(enum vga_switcheroo_client_id id,
 	return nouveau_dsm_set_discrete_state(nouveau_dsm_priv.dhandle, state);
 }
 
-static enum vga_switcheroo_client_id nouveau_dsm_get_client_id(struct pci_dev *pdev)
+static int nouveau_dsm_get_client_id(struct pci_dev *pdev, enum vga_switcheroo_client_id *id)
 {
 	/* easy option one - intel vendor ID means Integrated */
-	if (pdev->vendor == PCI_VENDOR_ID_INTEL)
-		return VGA_SWITCHEROO_IGD;
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		*id = VGA_SWITCHEROO_IGD;
+		return 0;
+	}
 
 	/* is this device on Bus 0? - this may need improving */
-	if (pdev->bus->number == 0)
-		return VGA_SWITCHEROO_IGD;
+	if (pdev->bus->number == 0) {
+		*id = VGA_SWITCHEROO_IGD;
+		return 0;
+	}
 
-	return VGA_SWITCHEROO_DIS;
+	*id = VGA_SWITCHEROO_DIS;
+	return 0;
 }
 
 static const struct vga_switcheroo_handler nouveau_dsm_handler = {
diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index f557535c1d7b..8dce19cd3d3a 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -529,12 +529,14 @@ static int radeon_atpx_init(void)
  * look up whether we are the integrated or discrete GPU (all asics).
  * Returns the client id.
  */
-static enum vga_switcheroo_client_id radeon_atpx_get_client_id(struct pci_dev *pdev)
+static int radeon_atpx_get_client_id(struct pci_dev *pdev, enum vga_switcheroo_client_id *id)
 {
 	if (radeon_atpx_priv.dhandle == ACPI_HANDLE(&pdev->dev))
-		return VGA_SWITCHEROO_IGD;
+		*id = VGA_SWITCHEROO_IGD;
 	else
-		return VGA_SWITCHEROO_DIS;
+		*id = VGA_SWITCHEROO_DIS;
+
+	return 0;
 }
 
 static const struct vga_switcheroo_handler radeon_atpx_handler = {
diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 18f2c92beff8..5ff222921d2f 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -187,6 +187,8 @@ static void vga_switcheroo_enable(void)
 {
 	int ret;
 	struct vga_switcheroo_client *client;
+	enum vga_switcheroo_client_id id;
+
 
 	/* call the handler to init */
 	if (vgasr_priv.handler->init)
@@ -197,11 +199,9 @@ static void vga_switcheroo_enable(void)
 		     client_id(client) != VGA_SWITCHEROO_UNKNOWN_ID)
 			continue;
 
-		ret = vgasr_priv.handler->get_client_id(client->pdev);
-		if (ret < 0)
+		ret = vgasr_priv.handler->get_client_id(client->pdev, &client->id);
+		if (ret)
 			return;
-
-		client->id = ret;
 	}
 
 	list_for_each_entry(client, &vgasr_priv.clients, list) {
@@ -209,13 +209,13 @@ static void vga_switcheroo_enable(void)
 		     client_id(client) != VGA_SWITCHEROO_UNKNOWN_ID)
 			continue;
 
-		ret = vgasr_priv.handler->get_client_id(client->vga_dev);
-		if (ret < 0)
+		ret = vgasr_priv.handler->get_client_id(client->vga_dev, &id);
+		if (ret)
 			return;
 
-		client->id = ret | ID_BIT_AUDIO;
+		client->id = id | ID_BIT_AUDIO;
 		if (client->ops->gpu_bound)
-			client->ops->gpu_bound(client->pdev, ret);
+			client->ops->gpu_bound(client->pdev, id);
 	}
 
 	vga_switcheroo_debugfs_init(&vgasr_priv);
@@ -364,6 +364,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
 			struct pci_dev *vga_dev)
 {
 	enum vga_switcheroo_client_id id = VGA_SWITCHEROO_UNKNOWN_ID;
+	int ret;
 
 	/*
 	 * if vga_switcheroo has enabled, that mean two GPU clients and also
@@ -374,10 +375,10 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
 	 */
 	mutex_lock(&vgasr_mutex);
 	if (vgasr_priv.active) {
-		id = vgasr_priv.handler->get_client_id(vga_dev);
-		if (id < 0) {
+		ret = vgasr_priv.handler->get_client_id(vga_dev, &id);
+		if (ret) {
 			mutex_unlock(&vgasr_mutex);
-			return -EINVAL;
+			return ret;
 		}
 		/* notify if GPU has been already bound */
 		if (ops->gpu_bound)
@@ -559,6 +560,7 @@ EXPORT_SYMBOL(vga_switcheroo_client_fb_set);
 int vga_switcheroo_lock_ddc(struct pci_dev *pdev)
 {
 	enum vga_switcheroo_client_id id;
+	int ret;
 
 	mutex_lock(&vgasr_priv.mux_hw_lock);
 	if (!vgasr_priv.handler || !vgasr_priv.handler->switch_ddc) {
@@ -566,7 +568,9 @@ int vga_switcheroo_lock_ddc(struct pci_dev *pdev)
 		return -ENODEV;
 	}
 
-	id = vgasr_priv.handler->get_client_id(pdev);
+	ret = vgasr_priv.handler->get_client_id(pdev, &id);
+	if (ret)
+		return ret;
 	vgasr_priv.old_ddc_owner = vgasr_priv.handler->switch_ddc(id);
 	return vgasr_priv.old_ddc_owner;
 }
@@ -597,11 +601,14 @@ int vga_switcheroo_unlock_ddc(struct pci_dev *pdev)
 		return -EINVAL;
 
 	if (vgasr_priv.old_ddc_owner >= 0) {
-		id = vgasr_priv.handler->get_client_id(pdev);
+		ret = vgasr_priv.handler->get_client_id(pdev, &id);
+		if (ret)
+			goto unlock;
 		if (vgasr_priv.old_ddc_owner != id)
 			ret = vgasr_priv.handler->switch_ddc(
 						     vgasr_priv.old_ddc_owner);
 	}
+unlock:
 	mutex_unlock(&vgasr_priv.mux_hw_lock);
 	return ret;
 }
diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 1417e230edbd..4f10e8c81a30 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -541,19 +541,21 @@ static int gmux_set_power_state(enum vga_switcheroo_client_id id,
 	return gmux_set_discrete_state(apple_gmux_data, state);
 }
 
-static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
+static int gmux_get_client_id(struct pci_dev *pdev, enum vga_switcheroo_client_id *id)
 {
 	/*
 	 * Early Macbook Pros with switchable graphics use nvidia
 	 * integrated graphics. Hardcode that the 9400M is integrated.
 	 */
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL)
-		return VGA_SWITCHEROO_IGD;
+		*id = VGA_SWITCHEROO_IGD;
 	else if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
 		 pdev->device == 0x0863)
-		return VGA_SWITCHEROO_IGD;
+		*id = VGA_SWITCHEROO_IGD;
 	else
-		return VGA_SWITCHEROO_DIS;
+		*id = VGA_SWITCHEROO_DIS;
+
+	return 0;
 }
 
 static const struct vga_switcheroo_handler gmux_handler_no_ddc = {
diff --git a/include/linux/vga_switcheroo.h b/include/linux/vga_switcheroo.h
index 7e6ac0114d55..cd3167ba2d02 100644
--- a/include/linux/vga_switcheroo.h
+++ b/include/linux/vga_switcheroo.h
@@ -119,7 +119,7 @@ struct vga_switcheroo_handler {
 	int (*switch_ddc)(enum vga_switcheroo_client_id id);
 	int (*power_state)(enum vga_switcheroo_client_id id,
 			   enum vga_switcheroo_state state);
-	enum vga_switcheroo_client_id (*get_client_id)(struct pci_dev *pdev);
+	int (*get_client_id)(struct pci_dev *pdev, enum vga_switcheroo_client_id *id);
 };
 
 /**


