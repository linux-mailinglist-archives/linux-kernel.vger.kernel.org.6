Return-Path: <linux-kernel+bounces-302549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158D960018
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848901C21E80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BFE2E414;
	Tue, 27 Aug 2024 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9qjjNDa"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4714A90;
	Tue, 27 Aug 2024 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731017; cv=none; b=HSuLrXzLrfhuCHCC0zpB2WVaGzwGQ9MJ4zfQzc5gLDO4lhHMhszl1IQBT7svv0sXdeh+DTauoS8XpgfUP9IEOhDZcOFYQt4v56G1LcFLbmV7WR2PpQQaJJDNjcdeJp/0fgTKkItvCPui+IXNeOB9ZBGgWEQQap+UZHleAGazKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731017; c=relaxed/simple;
	bh=2yqbwoTLn51851vf508uCRo/0TtNC/nkzS3LwVEiyG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGLcOF5D/BGqIRD+9659QOELVRbP97LXjUen8RSQM79zuid9K12uzQ4DoXQX0ztAeZWD0wAr7Qz63JYA79/lzFy59prf3hd4TeoSnsh14Ea/zzLsFqTKUn1YH7Zk9VKI9eWAGV2iMLPsnY6mkgsLVFdve0HixzHVuNeQ9B15fMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9qjjNDa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201ed196debso43338605ad.1;
        Mon, 26 Aug 2024 20:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724731015; x=1725335815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTvOR/DS9knaRzY3sdxLzqaq9zQJwZGfns9IyQ9Yg/c=;
        b=J9qjjNDa9byAU7hOKvkgD/Z8laHZRMXoiaiNCd7rBNRmdP4troEVQ5oaU+FgVbXCQX
         C4hS9zlE7VKiWLz6Lq209NNPU20iUhRd17xMqXFgQfwvglVI0pSRp7C4R8XP3YDbsjO1
         yWNkszaVQ14i5sYt/uQgb1U+vQ9W1Ou42htdL1AT7A/YSi9rsgrl4+SEYLwMdfFl7RC1
         AbwOUo1lKUy1PjKLgkYan0NaU5tC3J8pauqnT69rW4+He3sJbEj4qdmKDW01r7r9sxc9
         gZI6b+/+lzahDqRRtX475eC92rvPmdHGGJMif5r8D6H4+Bb4vhgraSJB+JR0dMgDtzbP
         mxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724731015; x=1725335815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTvOR/DS9knaRzY3sdxLzqaq9zQJwZGfns9IyQ9Yg/c=;
        b=qwAv82kKsECGJUPLXSzEDytNZPd4Yg1gSNaqvKd7SK+rqm+eUHVD3gt/ua3pRSd19X
         NKjQPGn7mSXJxZAV7Rq6x/w3XLN9z3sEjMQC96zDKU55kEzirWTEfNA907g0+vyF3kUv
         XHYpm+6PTfzzPdmeLqQIDQlpGUC5f68613dSNtDLtH+vSZkbWohcc4Qo/1j98v5ts7qP
         6YoOA9oc3W4LybEybYT5agm+bQNlWbUKlhW1KTJ9qFoLBC1HTRX3NpQA8CIUlWIzDr1L
         hufJeYgnOW0y6QDf4nR0X8jGOMa3tkc/YijAbyt+/vjS5O0F6YJVQ/9rbOyRjS5aQyDg
         XtRw==
X-Forwarded-Encrypted: i=1; AJvYcCUaDr8mMwRwornL3g8fTCD5eNl783DRZDsukLRrp2JesuD2wDMVkWFPOXapgQq0//Oj2dCq3LFaolq2PNc=@vger.kernel.org, AJvYcCUrUQEPPm8Uat+KOJ1CbXsYXtPEEBmYRDtESZIIw+lDbw9dwOlrkiqmw2Xyd7qmMX4YFAT6SgaOsxF2LsCD@vger.kernel.org, AJvYcCV6Y4fDNiLFkfbTYsf0eY0Qo3ROfydmK9yH/VssQlu2dFJb2iY3VScE+ZDHmbGzsvaRGdbRMLTvteZU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kfVR4JlhieijhMC2EUO0IKg1ZnI03sgjO3o+Mdw4M4gmVRjQ
	qdFZwBbKmQjM6RJdVHHDASzSZsMaQ2OAKKAOX2Gn8o39RRD0qQmyevmj6w==
X-Google-Smtp-Source: AGHT+IFxneXRFmZ1WmEVJIBaliCW7se8z0sLkUpG6VSRORjfjkBu0029f/W74ZEp6JtRVQdyr0mBRA==
X-Received: by 2002:a17:902:b20f:b0:1fb:72b4:8775 with SMTP id d9443c01a7336-204df4d39a1mr16138875ad.40.1724731014747;
        Mon, 26 Aug 2024 20:56:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556657asm74264205ad.47.2024.08.26.20.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 20:56:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Aug 2024 20:56:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Khanh Pham <khpham@amperecomputing.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: hwmon: Add maxim max31790
Message-ID: <3382f952-daae-43ff-bb85-fa4820ecbc5f@roeck-us.net>
References: <20240822084808.299884-1-chanh@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822084808.299884-1-chanh@os.amperecomputing.com>

On Thu, Aug 22, 2024 at 08:48:08AM +0000, Chanh Nguyen wrote:
> Add device tree bindings and an example for max31790 device.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

