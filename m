Return-Path: <linux-kernel+bounces-515351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9B2A363A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF63169547
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6949267738;
	Fri, 14 Feb 2025 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3NB8Nng"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025E262816;
	Fri, 14 Feb 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551933; cv=none; b=jmHwV+xgMPfmlXSQ/5TzUzzoiPzJpoH/paPCZlrMSAWtAcKq0C5GqXplbGI4ltjApcseBE9Kt+czF+dFeQUBxrKKTE16X+SFDbfjeolnYjtfaFY1KjADkIblnD/CQYWUMh1CTf6Kz1Cl8f6Zv0Zv+a/Fjuls14t1fcy5rliGrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551933; c=relaxed/simple;
	bh=2aLANwhhuGIBfOSsGjxjZmw0vIoBglET8Z9bA4rj5VM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VuwowI4TrdNnrEWaI6ehgJmrsJPbJUi3FfZ8U25PYBKqWO2oeUJ+ZKnuldCqf+tb803CuFPW3z7DoB8rPSBBzg8tXnINVTjRHRfw2ddUaJ0bXy+sSYIMYd3msq9Bk8Wk5aKpVYehk0E3TTc1ZzCXW03r66XJwZDgUdTx8sA4xtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3NB8Nng; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e587cca1e47so2098096276.0;
        Fri, 14 Feb 2025 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551931; x=1740156731; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aLANwhhuGIBfOSsGjxjZmw0vIoBglET8Z9bA4rj5VM=;
        b=d3NB8Nng/n7BDpwl8zPOLXUXKzSF3Wo48p8g75q3q6Jp2zINy1WbiKVwBPhfBlEuoc
         bD5PMv/y9rqZqkEqP1LEY2FuSqqty7m8lELuV3lr/iXRL6FDOjnbIBM/+bYlSV0zoFgO
         buFLOrmgeED+wjQp7VL9qZ077O04aE+P7i8mQxyo/w3814+cEqXLfrmemJQxYjMr5jR5
         HK7KonEh614M4XN3LQ3PiobC0KLIrD4O/7sy/RPd0XMP3nSVSBB8R96SzP6FXIywqapb
         4JNfT/Ui5MxCUbYlfCfJhQb+zf0dLz9BEcLN0FSEzH1LzeADxfhY0JpUEnMjDhEGEF6e
         0lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551931; x=1740156731;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2aLANwhhuGIBfOSsGjxjZmw0vIoBglET8Z9bA4rj5VM=;
        b=uU74bxWsONkjhv4bl8nEWfWA2VDGmH/u+jREPGmRd6l7l4sF9Fv6p7tK1ysb3Fku4x
         ZxD+2ndCUlMOog2yXgOJa24hNDGiCzT2fq7JXsCouhOUNmupVVWtPPKtxILJZxYxQEzR
         tiE1oeV7x4G9VEN09K1zn0BnTI95LWGZTQCeMEUpqe5RKigAKoXBTV66Z073tPtQn9B8
         436S3mlSJgJDkbNt+KnnhRpEWh9/L/QS64092O+mGFstyyl6O61HgJuu4a2qXfKl4BJp
         Jt6zhF6/wKdwyRlFpPGxcZPYafPlmuLfc/vAEyLeSKnibUFCt5XtC9WWQHTiYzGcCXZ8
         A2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEUq7096cl7M8uLiGfblmFS5w8XWPdkvZ98SrFNdBthMlf6/yCCbKchxoVh7Og6rpdiy1bCMcyZ0C3SK7iGwBOTiDj@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMoPfY12vIwM0E37rrSw7vUk3kB309b3pYsjzKq1ibFBQnUhi
	PXKsGIbMlu9tG1qM5mk39CV+YWPRIycQMkNmg5q6DUbFAtWVVsa1
X-Gm-Gg: ASbGncsEeFE1wGiz9pFCT1TLuMCfVYLELPIOT60qSYBHGww16gLf3yxi5WKsVC1Mrwk
	Ay3KODR6EXVWnhtbwOUSJeQdjDRwAtxMzC6bbUo88O4FgFPfJbaLboo1u4BHiGMBKRKRrNaVzpz
	bypHSMj3KXmlcNIgdvwhqU2UoiA2wOBJcV6DYk+44uswBwD3ZHDAxYsCEMV1JeVTHTsN/JD0Z0l
	MOjn4jzcKtPtWctXHX+zCwcG05z4fsa5kUXCZRBxlXC2uYECwv05BPtPVieQ49Q16oK8CHdI5TS
	aLkvayM=
X-Google-Smtp-Source: AGHT+IExa6mE2cGXjZXyspkDW1qPwoAmdfUIQuHqeGEqMN+nXKjGk5TGN7vZvfLGchSI8wQe2FZzoA==
X-Received: by 2002:a05:6902:f82:b0:e58:a25d:5696 with SMTP id 3f1490d57ef6-e5da04b4095mr11429353276.45.1739551930930;
        Fri, 14 Feb 2025 08:52:10 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae0d723csm1063431276.40.2025.02.14.08.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 08:52:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 11:52:08 -0500
Message-Id: <D7SBOZQ502TY.1FO1QG2GHPM6W@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <W_Armin@gmx.de>, <dongeg1@lenovo.com>, "Mark Pearson"
 <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v7] platform/x86:lenovo-wmi-hotkey-utilities
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jackie Dong" <xy-jackie@139.com>, <hdegoede@redhat.com>,
 <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250214154033.5483-1-xy-jackie@139.com>
In-Reply-To: <20250214154033.5483-1-xy-jackie@139.com>

On Fri Feb 14, 2025 at 10:40 AM -05, Jackie Dong wrote:
> Tested on below samples.
> ThinkBook 13X Gen4 IMH
> ThinkBook 14 G6 ABP
> ThinkBook 16p Gen4-21J8
> ThinkBook 16 G8 IRL
> ThinkBook 16 G7+ ASP

Part of the commit message is missing from the previous version. The
short commit message is also missing=20

": Support for mic and audio mute LEDs"

Also, the MAINTAINERS entry is still missing.

--=20
 ~ Kurt

