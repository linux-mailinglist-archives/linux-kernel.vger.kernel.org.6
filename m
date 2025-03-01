Return-Path: <linux-kernel+bounces-539659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFECA4A6F9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9033B5C9C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7575FBE6C;
	Sat,  1 Mar 2025 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ArDejyUX"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3D8F7D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788903; cv=none; b=hQTjD1saVzIHWSxf8YsLWO7Ao6FVE14b+TdD9UA00/f1tus5xR7+HRMavEVWcmAGSnfSydAsf6lY0P5/WkLj9RPEAaKLwWoCiMNQixpBEfSn88pPk++8ZW2onvET9YzRnl8pgigRE517QIBI9AnD0D4DhxumMODyTvFytvzROWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788903; c=relaxed/simple;
	bh=etpaj8E6HzSygIZNR+IwBTh7AHHX2A8bGyqGJTitllQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUx7pj+iUGtx9UAnMuhmwxjBHBg8dxQj3Y1sTdsi7/0wASoGTKN2BABU2Bp5gDRJxYcT6z7DfOMva0Qi8yhSwK6RBGs4Wo5/I+cPZ6OcULosN0kJSueh5F6eZLKtWXkjWFCyPlTUSvXvfZGxmmN8EYWoqe/UJwSE+CucR6huukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ArDejyUX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e891e447dcso28796296d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740788901; x=1741393701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=etpaj8E6HzSygIZNR+IwBTh7AHHX2A8bGyqGJTitllQ=;
        b=ArDejyUXl84+MMfivgzMq/VvKXSev7fsD6mbAsOubTRCNjTTy2yZPBtmBoVIy7Qgho
         lZ5nC5vw9b17rI9kMM1Wt6GHWkjhvlLWuXa+DldAMV8isRjwZOgXbRFdSkvHOe1LeF4M
         VT/8z8v3L17oQhptK7TeAMUL/YF3WhUGSjg5LxjtmHG/ZneuWiMdShDzq5mIcpqNxt+v
         qZn1ZfGHvL0cFHjnIcM9PkTy1PNtUaT4Lz4c8GhhR6ky1kl840bdNbXe/rsKArOGoVIO
         cKnvtViMKUN75903ZKpdZj+2V1J8PVN8rMX/4XRSMjWlnTeARUqpfazB3VnBX0/dQ61T
         WesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788901; x=1741393701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etpaj8E6HzSygIZNR+IwBTh7AHHX2A8bGyqGJTitllQ=;
        b=TAXoMfl4In4LOZDKby2diPLiUDbilWR5e0aTtXb6bBqDzW1l+918ldr+d5oL4lh0qP
         1X1Vucg/m+xZERVmIUn87+8g/Yp8wf7jI54Zr53lijT3zy4plw5Sw34kVADfKnYOQ7Ui
         mm9JLLH/gwEbUyFYt6l8ncVKn/q122D6divY+uKRECAQXamNOEFmjigJLRrxZ1KsKduP
         +fh1O0APi+2JOD3vVJom56RVTm7Bj5Rq2kFcbhX9IE5mK8Z8GY5goOJVLtv7Gt7waElp
         5HMS4qJxkDT/vLpuslrrQQZ+BXPID3LoX290W1uf+3fiteNAXbkoye2Smp2eVAJIvBg1
         rpYA==
X-Forwarded-Encrypted: i=1; AJvYcCW+6AZaqVVSJ9BjQpUidkaetF5w/um+p5GdGOEqj5Yq+NHdpRfUfMBKklWHCWOfb6MuHHd3MqLKKikOF+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5ocjgplIITTRkXXEeL3xuTkLFdz/y3PpNx8mZ7j+zw3A3+tX
	HGXnr/78Qgx98V2sgpx12l0/E4gWnMyn69sgAGAHR1pwjTgNm2o8mSpMJT707I4=
X-Gm-Gg: ASbGncsuw+N3ovZHkeyrzPC2OBOxbEUhieoAmeHFBUnxOvvYPQilIwHf/GB0l5B94FO
	3Rf/iQVxvISqiwFjLffH3vZQZvMnTXzAqPVf0JE2pL8BmP9+GTxwljTtDgiJ084RJPNeM5+BHHQ
	IcIX1/6ipqirfa310HY/ss5OwPta6i9X/w9c8SQHSppYGD1F2AjUwg/8Ec8dVSO5Hae6oCMggDy
	Ir3mmM89pmBrLz56x1WuEe3iig8utLUZsB48cvQqn8YpnZcvjMz/PCjq4qLXTMsPh1kFOUO5HLm
	SYx9s1osTYeOWouyEiIJo9TIcwB3MkWEcA+4QuotERwd/JihZthsS7M8jXB1Kv81wOFwyQlp7xf
	svt1ciJRExUAQSkhpHA==
X-Google-Smtp-Source: AGHT+IGWUW0tauc6sDT2qPhkNDpocp6ePHjchDO/mgzAg7gbE6xKrSwlcBJaiGl9R/g8B01dEdQcag==
X-Received: by 2002:a05:6214:262b:b0:6d8:5642:d9dc with SMTP id 6a1803df08f44-6e8a0c9f135mr80504936d6.11.1740788901200;
        Fri, 28 Feb 2025 16:28:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9fe15sm307375585a.66.2025.02.28.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:28:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAiJ-00000000VMt-2hZA;
	Fri, 28 Feb 2025 20:28:19 -0400
Date: Fri, 28 Feb 2025 20:28:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <20250301002819.GO5011@ziepe.ca>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228170720.144739-6-sgarzare@redhat.com>

On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
> +/*
> + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
> + * module_platform_driver_probe() this is ok because they cannot get unbound
> + * at runtime. So mark the driver struct with __refdata to prevent modpost
> + * triggering a section mismatch warning.
> + */

??? Is that really true? I didn't know that

I thought you could unbind anything using /sys/../unbind?

Jason

