Return-Path: <linux-kernel+bounces-440134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597939EB94C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2D616520C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBD02046B3;
	Tue, 10 Dec 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APg/aPMF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5BC1850AF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855148; cv=none; b=eL941fQNWWS67meY+eteIcIwso5HyrLPnycHDlrsrOwpXwj1I6NDHpYB5n77vI31pYplgSo4yp8ZgZOrpxlRY/EBHel9u2c0i2IlmPVcvq2to2EOIVsbMXO4fDa2mJ2cC1gy/LKe137Vd2Y7AxlvbbW32jnrcYauOygfkFwml/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855148; c=relaxed/simple;
	bh=k4wzfxOojBUBvLhldZyzw9pR/2FXLrnoy7dBYKIUzSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spagSn7Bdi5AqnMwBevVzgcBV3PY/NNBn9X03rtMwS5rj9AlrylDu4ruvKtHRmwzqx92pojDtVHCvlthfi/Pu7/wNazomM36ea1Vny52K0Rt0xvLjwKsX/LT0Hf56uZu4hwoxnEhtLMgE4P06ZCyHmd5RCKyVGRz/lH1tRoTwag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APg/aPMF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733855145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoEtxxxpYuZI3iORGeBDOZ4vaaDQlyDsJJuUUX5DkmY=;
	b=APg/aPMFFAYpUYd9tmZTul6xJnMPFaPH5DBIlqnTaK4PxiN9AKnZ0sRlZ1RKh/eTtS33rh
	9dc9HkPAVknqPYpy8AgSdnF4lzFDmwO8nLCA7brUgWChdhoJieYLeKegDSIdaYKmaI7GIX
	7iGBEkIaXbrvAsRAW8TLdABzkUAgd2c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-dbJ6wBeRMLSMH4NY7qT7sg-1; Tue, 10 Dec 2024 13:25:44 -0500
X-MC-Unique: dbJ6wBeRMLSMH4NY7qT7sg-1
X-Mimecast-MFC-AGG-ID: dbJ6wBeRMLSMH4NY7qT7sg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38629a685fdso1880904f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855143; x=1734459943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoEtxxxpYuZI3iORGeBDOZ4vaaDQlyDsJJuUUX5DkmY=;
        b=BDSzYP7ldawWao/wacD/P5KuijOyc7k4SygN1w3BKyPYR/KUrwuyhaIkk7OqORkKg4
         k4mlVxKHPripnQm6P03GfUbBkx1y2r2228dcQ47gSQ+VW70+YdwQoaonmHFCjAF5KTYw
         AL0g70vmZPeC8CJSlHYA8Ob87ZDEsYyKXWf1k4WlyJb9udiJqC1VSzw5KTXTuXQ0Mxux
         wVQJbNvsyNss1KKYcERLxTEOlUHB2mCmt9wWdWO5YLQ5OpoudJJTn1TkzPXZ71FzeqBB
         tXpYD8VEJ7qEp4T7bjNDDMdd8WYdzI/XgmhV4T/cM9owMvK/cCCZRiVK1t9tR8E6BewD
         KSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmc/OonVXr4z92KRJxfQgooYVOAKNuuSlYDWo/g20zBfJa3Cr1qvdAJZJDi0EdENYKYqbwhZwQlvNCE1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5VyX9Tn22km3P6XMtoGRRvwxLlNuMK/imRfwaWcJqFVqi3Oh
	XnwTGNLv5oqeXX7+V3O7DHj9f3n99qJjcVqtzoK+ka4c3u4sA4sa/UZkDDte3mw2MRlGycvVfDA
	pf3ihNzZP9Uwe3REXyOzBmKEusL3pTPgzWdUe2Co9YsCppwvl1Ql0y/9nljx3eA==
X-Gm-Gg: ASbGncuv6d8cQJ7IpgYBVjRqFgx67Vkmf39SIaFs+aitEe1OQ0V+XP0dtkRPrmf54m0
	TO3NaTDLMRiVz0OqpQ0Lvn2axUosL0+Ww5FjOOt51ly1lBs9t9KXKZDnJDQHcw63mTs3W8lc+Ju
	xGUqXmsNPKPDVWbdlE1QGbKsCt0FWZ/iH+cfhZ+XxTsuqbdUvlNoQS0ic8BLprOpZKOy9zUyXop
	zrmafzOfAmm2TlDccBWvbJsz6I9sJ9og8KRbuNE9QeRztnYa+X5+iDv
X-Received: by 2002:a05:6000:481e:b0:385:e0d6:fb73 with SMTP id ffacd0b85a97d-3864ce54f0amr112953f8f.15.1733855143424;
        Tue, 10 Dec 2024 10:25:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI+QSI1+vQ+6ZXpVlwgCnA1S1qju3LR+aV0K5ZSuhrnWB6Ldus7kNlvjfrrohMbCFm+Fjxbg==
X-Received: by 2002:a05:6000:481e:b0:385:e0d6:fb73 with SMTP id ffacd0b85a97d-3864ce54f0amr112928f8f.15.1733855143104;
        Tue, 10 Dec 2024 10:25:43 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862e3fe716sm13304165f8f.7.2024.12.10.10.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:25:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	kai.huang@intel.com,
	adrian.hunter@intel.com,
	reinette.chatre@intel.com,
	xiaoyao.li@intel.com,
	tony.lindgren@linux.intel.com,
	isaku.yamahata@intel.com,
	yan.y.zhao@intel.com,
	chao.gao@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] KVM: TDX: TDX "the rest" part
Date: Tue, 10 Dec 2024 19:25:13 +0100
Message-ID: <20241210182512.252097-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210004946.3718496-1-binbin.wu@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applied to kvm-coco-queue, thanks.  For now I used v1 of "TDX vCPU
enter/exit" as it was posted, but I will check out the review comments
later.

Paolo


