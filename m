Return-Path: <linux-kernel+bounces-440126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BEA9EB937
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9D165458
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321B2046A0;
	Tue, 10 Dec 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG9Kx6R7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3F23ED59
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854942; cv=none; b=ekLg9LGWrDXwOJ/HMBNlNZNpwJ5esOfEo0JCohB5Uzs+YmnpaARHHgtlChVK+5aQ4vHqb6gaxfQXjV56XCfOSGZisV4sdgEXEvbes8yzDDk5/5KQxjTeHwEz8OhU1pykeEzt3nmAUE6VIHEeLKcmxzP2drdaX2Z/3J0WqXRiy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854942; c=relaxed/simple;
	bh=1pHfdGZ8TK0Gn1cA1yV/fONw8m+PMIvPeERxVbGEHKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2W7LXqIguAmLzNWmFWnFq6H44XYfhiXOEdY69CxrpPKxmcWVYopZYnvAe9cf8Mtj6s8TqjO2EzqJ/i2Muyv9pYAU/mygU29z7qicIiDVAJrOvFlexmbToUZbOEJGq5D/afMIzYPkP0z5l2obcHeJeAhZFOXQmul6+Dysx2OWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BG9Kx6R7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733854939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOADznZ6shRkxpA6k9z+HUBrSDKj4HgVFQ54YvYLX9M=;
	b=BG9Kx6R7uMtILMmH66eyw6eVH//HQXDgdzNm+8ahpm1F6FEGdkzv7jKqTmqSWFdEfbRbaB
	qD9xnpMymPGY5IDwalNi234UYZJsFSKm5QZJSqGt9GaJBy/jYVZemluYpUyM8l9PGAsm3G
	i9OV58slS9DzMi8gu6/2gJjxx7TGXes=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-n2Px1cScOUSlb-KE1fF_Ag-1; Tue, 10 Dec 2024 13:22:18 -0500
X-MC-Unique: n2Px1cScOUSlb-KE1fF_Ag-1
X-Mimecast-MFC-AGG-ID: n2Px1cScOUSlb-KE1fF_Ag
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385dfa9b758so2360714f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733854937; x=1734459737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOADznZ6shRkxpA6k9z+HUBrSDKj4HgVFQ54YvYLX9M=;
        b=AUXXx4W4olrhV6nLJ/9BymPRx18eXGST/z5b6WQApwAaJonykDIaeU2RyagWXc9IDA
         EyF57HdENa8Ekf+1+eHetvJUCmoEZhNeBx/kVFlbo/7hNfnVW9tAexsEmAnjmXKjHCqw
         4mIzv5F9stx+yDvWl3GT/0cg/knpaNk2LRfGQGhKOv0GXe90ilsL6tCOW+btFWsnvwtB
         Ihps+p2OM5wbjvJv2YtljCAZTGoLpZNzuctZttAQLUrTYf9NPvfjloyxCAdbLQ1y/rZ9
         HqUJf5ChPUacV6HOVp2ZifX1iDjU4o1abdNDLgOxP8K+0NUm9zNPz0NHQNVEt72KvYZ1
         CunA==
X-Forwarded-Encrypted: i=1; AJvYcCUj2J7APkxHZV7Cj3lWLRnzFSyBJ2A4DWTbAola79HpM3iHyUR4bLdrawCCzPSCFH3PWFy16RbG6rSTp/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH89ttEKwwX4a38wFCi60x0psRqp5X3aLjAUKatRXo8iprxfcr
	p0o0ELBBpXXYnw3FPEdzch/Ex09u8kzYSrFjncVat9rVaUHwFkVdxZNbovpUZ3ncMozlAYPZATy
	NL69M+He+AA990Qa7ake8AftmXfAZTUxddblBl3EtDom/pYUosXw1GHQ4IktpsQ==
X-Gm-Gg: ASbGncvnf4LK/sXsq04QjtAwgyTZrfHuhwibJI8NJuVqE2ckvw79mdizAy2GML30P6V
	xHZqmfY9kkV53aUDwBqvgCYjfSJBlBRQ/aMPh/4O9/13MtaafRBzwmrHfELcuMCdn7H9EtHy9jo
	GLBXgZ2ZEYPv5e3JAFlukLpswwwiCmwykJiiKgVVKhGuvRgUIQW08aT4KNyJm1/uIRpUmloOhlO
	BqigU1LIPpMLJHiqFC9JLNI73dV+MOGKHOuD3MiFeLmvilsI+PGNoFE
X-Received: by 2002:a05:6000:184d:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-3864ce894a8mr101554f8f.9.1733854937415;
        Tue, 10 Dec 2024 10:22:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUJ77YDtXN6cvySvDYXOgTSlRflMAT/JOMpZp5d7B2OiXlMT2r6y/f/JDsGlP5KLnA6E2SuA==
X-Received: by 2002:a05:6000:184d:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-3864ce894a8mr101539f8f.9.1733854937041;
        Tue, 10 Dec 2024 10:22:17 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38637111f88sm10383997f8f.98.2024.12.10.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:22:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	kvm@vger.kernel.org,
	dave.hansen@linux.intel.com,
	rick.p.edgecombe@intel.com,
	kai.huang@intel.com,
	adrian.hunter@intel.com,
	reinette.chatre@intel.com,
	xiaoyao.li@intel.com,
	tony.lindgren@intel.com,
	binbin.wu@linux.intel.com,
	dmatlack@google.com,
	isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	nik.borisov@suse.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 00/24] TDX MMU Part 2
Date: Tue, 10 Dec 2024 19:21:57 +0100
Message-ID: <20241210182156.251791-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241112073327.21979-1-yan.y.zhao@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applied to kvm-coco-queue, thanks.  Tomorrow I will go through the
changes and review.

Paolo


