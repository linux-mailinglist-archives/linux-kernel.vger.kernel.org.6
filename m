Return-Path: <linux-kernel+bounces-415728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F5E9D3A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32259B258DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5686F1A0BD6;
	Wed, 20 Nov 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0ytCxhl"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458AC17BB2E;
	Wed, 20 Nov 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104865; cv=none; b=psEzZUtZZ7Rxzu3UWA++JQoEfSDSYnIB5UJJvYleYiebCKk9ZRKSf6lksAlQUf8Q8UqbAaNtGw/u77D//mstZaQBSfXaJvd7oqiwEXOdP54DKW0oJl6VYTK87P15Ti5RBzv5H/nzIONuIkM9QPa4pzEwtKRPrt46ZeuKsIZZM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104865; c=relaxed/simple;
	bh=PzbFJgpJejzo+/+XvbJzbk4rHHTZNfWxfCMGHtccwj4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=puqi45N58tXuitv+G2tUShNRzBJf8EsSpvfrZ6fOOOnDqnqhgZP1d4MXK2+WFQrh4WSST40t7gMHPKHclwqnYFcxz6m/rJZYP98fExFGqyuRlRgFnbTLli+B2VfhHPYROMHLthBdNBFK1u6Vae1z1Aglo6nMLpBsE1w57mFl9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0ytCxhl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so329487066b.3;
        Wed, 20 Nov 2024 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732104862; x=1732709662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PzbFJgpJejzo+/+XvbJzbk4rHHTZNfWxfCMGHtccwj4=;
        b=f0ytCxhlKrDOMOC+QiPOPqGAamz8eBJ361CKlQSYlTNloLhSldiSZ1GHKjUqijjsGm
         3SegBO+lrNZvi6/bLdTRHkabDLKLe2Gsz2BkSk7NpJi6Uynv6zHpC4EH5nO7t5ru+5qu
         LcgVcjVjyoEpG/g9KMRZHdj7Sci+FQcftTJAHTV9/poBATHaWitzLjQKMrfUakZCWFO8
         yoTuP5EjmqMVefNy9BTFMX2E4Zf3vtuhC8YfcCqjP7i089RbEy1RrZDA0mj8GZYkj93j
         Z9seRIXAJ0B78qi6GaRK5GoMdRgyvQ9LicTbtsYjIzexr1rVLtiXBYEpnywPVwiVJPfO
         ECNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732104862; x=1732709662;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzbFJgpJejzo+/+XvbJzbk4rHHTZNfWxfCMGHtccwj4=;
        b=eSHn4zuuytCpKmSrqBKM72m5ssbql6ors7WJvsVbuSduzE2z3RcnHAZ2v3SmBqRlja
         kz/OlhbVDADyZRFSez/ttk/XfAFbVUcxGKxcZ3dtqMXWPnipWyvH/giFSSyDTJnSos6j
         YQHr/JPBvA7H0dsjx+GfesReZEGEIcS3hhVwox7Jk0I8vXHRM8NNPO3kKMW/1N7ojfO4
         DbKI5u2Y3bcG8qM3WCAa2IK8InPDJCh4Fc28PXYGWKTY9Zc7CiJYGtkIvCUk4bMFHkY0
         LhPxgc9i0LoIwCIFeh+1nj4OIiKi2QZiKmcMFPArK1zkwlIJQmoAVd/g5iZ/Lh7wzcwq
         5NNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh6brVIiuP/uCu5U1+MhIe2BzmNNBVm3OjyR7vSjmG4/HMIWB0V9cDaigFQpgGqxSLW4DXF6FzcWf3@vger.kernel.org, AJvYcCWxZZDIgi4w/rHBKQhY9fsxvLwMqpaPUth7vxGawqN1bqMH38xkyYnBy7qj5sntxNSH9VEaBgDk+z9OMK8R@vger.kernel.org
X-Gm-Message-State: AOJu0YwC9Zo43LdFYJwiwU18bd8jqelqgU+0gyZ7uQKtGsaPsWd4Un5I
	lbdgz87slqiW2ja1luuVyNOZCie33KHOxD8MiUYMwsEgi0wgZm2rSlWY+Q==
X-Gm-Gg: ASbGnctjxr6AwhXz016mbe70Gbsu6jwoQU7AD8funqr3esrEji3ss90jruCPoFKhBPa
	GVami1XVNa5V6LgfkakahXwZRY81R79Mm5WekDQs93XdQiCeNNLDTdycSS68DndT/S0+SeYCseW
	sz7o0jiRCnL2x8QZa5d+DMbz2ROH3b61a9vjbzCn1AaaTvox9wHIUJTMPoMNv3eIbH0gi8mE+Jn
	ZdGEfJc8cYE047fDek4xd0ImfyI8HktAEeHuQU5dRkTzy5n3AikQWC4G1gtgpdr6+kX0CzoiKcn
	V6+RlEVXAi6K0A==
X-Google-Smtp-Source: AGHT+IF39oYsW7utHgxHuY+7iTrA3rGekAAdCC6unwDTRCMsuaP4chYqSaWzpfz/ubmLWvb6kY2vMQ==
X-Received: by 2002:a17:906:daca:b0:aa4:9ab1:19d5 with SMTP id a640c23a62f3a-aa4dd70a22fmr218519366b.42.1732104862437;
        Wed, 20 Nov 2024 04:14:22 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df56b08sm766292666b.79.2024.11.20.04.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 04:14:22 -0800 (PST)
Date: Wed, 20 Nov 2024 13:14:20 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: robh@kernel.org
Cc: baolin.wang@linux.alibaba.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
	zhang.lyra@gmail.com
Subject: Re: [PATCH] arm64: dts: sprd: Remove unused and undocumented
 "constant_charge_voltage_max_microvolt" property
Message-ID: <Zz3SnIiW_iu10rrs@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115193409.3618257-1-robh@kernel.org>

Hi Rob,

constant-charge-voltage-max-microvolt is a valid property, which I assume
was the original intention here. I've already submitted a patch changing this
to the documented property:

https://lore.kernel.org/lkml/aa557091d9494fdaa3eda75803f9ea97014c8832.1730918663.git.stano.jakubek@gmail.com/

Baolin also reviewed that patch... make of that what you will.

Regards,
Stanislav

