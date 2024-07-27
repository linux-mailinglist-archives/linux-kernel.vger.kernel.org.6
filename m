Return-Path: <linux-kernel+bounces-264203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C90993E029
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B101F21B31
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEEB185E73;
	Sat, 27 Jul 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKRIR57t"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75A41746;
	Sat, 27 Jul 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722097853; cv=none; b=ZvEFBUHq/Cqn1P/GzXfz/ij557XQnC1adGZN9sHUMyIuzo5w6Iw3QPGDrXeBrwr/zNsNzIBlkDsTMfS0lQNFYvrlShQQyGJrjjbqu/FXr90uj6HU1RZNIYpyE+gakGFAGigUf6aE8YxiCiotTPg7PEH5o+WUWVz6hi3a6Ry1KAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722097853; c=relaxed/simple;
	bh=+vsnHt5Ja3DaktxdEBTWYyCS/lDyoapV2AbOb20uF+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fppyX5fRr1QyMjI8PtbJLK0eIihJKoe1Du2AiNIpiQ1+B6gvDQU8CDsNNhQ/X1fO1g0n7Cg3MRlrewJc8mfxlgds3QYjTvYgBKXyVbTUgshb1NLiDTuRhzn52KfrdTR//w6FSGe7jHZQfk9FQJqh4TQWNsaw3c+grPzG7pwVF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKRIR57t; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5bd1b79cfso1190173eaf.2;
        Sat, 27 Jul 2024 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722097851; x=1722702651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSZQAyMIRObm618hS6wHfoirqkRF5Nnp2L7TvwbLNbI=;
        b=QKRIR57t/vMiCyIL8dq9azd5anX5orqD+M7mseZI6ceirHh5HZ9aSkIh04T6ttv9vA
         I7+TnVwUHkawtEV1HFOfdkIeWhAgk3Ovh3tZjLhF49tz/g+SjayYr5YHIvOQC8yd2OYU
         qo5WXS9WKKpccrCToRMvxlyc05QmvVqfXMU1jKReksCodQcF4GD8mtryrRc3IrJmL6Mm
         2emW00kXRUxKFlDJiNhlIW8CDPzESws7xoiaSGxg3ZR16cOErVHWerwSkS9pyvXh5NJL
         ka7eR1atix5Ulv+7tDcaL/KRTmWY+YOs/rjDE3ku7q8vkcasDmgnbOD6XBiZtS+yhyl3
         XPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722097851; x=1722702651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSZQAyMIRObm618hS6wHfoirqkRF5Nnp2L7TvwbLNbI=;
        b=peUVMB8GSa4IsQcEg9lExxmkEMZEmIN+MEKLb9KFW8rmfpSYxO2GzXIpSZBvKdAP/L
         GIOCgk0Yzmvv3uP9auvRaEJtRCa2rvOyt3XgwURBT4uSepgUQl6E1l/u3XRtFqlzijRI
         urLYXgBpA3CxUD5Sbs7snaujoR5R9TvZ4V9JVGDRQy5Zg7wG+WUhpSmX3vIRwn0WE9DE
         xo1QobG9ojfmwHlpyw8KNcS0mE9eSjwpzDY6DvREMuxzPZXzyhIZUKXkaQpr9mAqkleU
         +qoFWv47hPkWZ7Oci0RC+AbWyKV1t7p5unJM75TsTtERxYWhX9E7Xe/fw5Hi0GaTQMsY
         /bkA==
X-Forwarded-Encrypted: i=1; AJvYcCWbNLDVUiDh9a9G3iAImCs/RWmPPY4CzdKVpkocHFrEcLTTagPG6gH5p3VEEjImowVUQbtic5RnevelqFwe+EJPnQsGEa1CzD870HzRj0l1YQtDOv7G+9dYNEVgPomtbSLzUSNC9kNB1g==
X-Gm-Message-State: AOJu0YzzQJx5cJiYraiXcg1plxGgvC0Siv3U6tTyBmBBKWBTkSBwCQUz
	5Hp00V/0l4E8NV2aAVHcztB9e4ba4kWhnHxr3PsinZeuLiO9MG1ybjegfggC
X-Google-Smtp-Source: AGHT+IEX+cctMy9+qbckneOibrEfIU1roDKKau6ih6elPcuSQOKlNgrpj2aZKDnI7HV7rLbOHmKljw==
X-Received: by 2002:a05:6358:f07:b0:1a4:8048:56df with SMTP id e5c5f4694b2df-1adc06ca0bcmr249912955d.22.1722097850909;
        Sat, 27 Jul 2024 09:30:50 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f925de2sm30472186d6.64.2024.07.27.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 09:30:50 -0700 (PDT)
Date: Sat, 27 Jul 2024 12:30:48 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mehdi.djait@bootlin.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Message-ID: <7zpp4ebzj5xk3wbbpt7l5xnhqg3i52mdjhn3grmn562mres4k5@a3g2xxftk2td>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240725004734.644986-2-lanzano.alex@gmail.com>
 <c7bf08aa-e7a0-4b60-b9fe-b43215ce3fb9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7bf08aa-e7a0-4b60-b9fe-b43215ce3fb9@kernel.org>

On Thu, Jul 25, 2024 at 08:17:01AM GMT, Krzysztof Kozlowski wrote:
> On 25/07/2024 02:47, Alex Lanzano wrote:
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sharp,ls010b7dh04
> > +      - sharp,ls011b7dh03
> > +      - sharp,ls012b7dd01
> > +      - sharp,ls013b7dh03
> > +      - sharp,ls013b7dh05
> > +      - sharp,ls018b7dh02
> > +      - sharp,ls027b7dh01
> > +      - sharp,ls027b7dh01a
> > +      - sharp,ls032b7dd02
> > +      - sharp,ls044q7dh01
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cs-high: true
> 
> You can drop it.
> 

This is a required property in order for the display to function correctly.
But I have no issues removing it if there's a better place to document it.

Best regards,
Alex

