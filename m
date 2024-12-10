Return-Path: <linux-kernel+bounces-440133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269A79EB947
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A1F165A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C58C2046AF;
	Tue, 10 Dec 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYGV5PKr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247D86357
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855100; cv=none; b=G1ZGazzU0gBBHBPH2TXo49Q1SPl/ADRXc12l6J63nNEvMzu0ScMdobGXOZEsxRsjbpfYnb78eBnpYL9/QERRbf17hOgBpRT5afg6OaNjb9RDq/RLhW+oK5592JReOjyBBt4ECZPJ1c3olZcwFtWMcfL41voK4VDspYjtR3QkMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855100; c=relaxed/simple;
	bh=7nhMPj/ozuoD9sVD9Ow1ZB9+eVVLEWg/CeyeINkPCXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndYUcImfYkzSjNcNgZ7uJH6v1LA/4MnxHrP9cpqThV7FqahCfTX9U030d8CAFG9O1FhnhMG9r/4ByVESkl256k+6ZHh9NHSNqhUUplXUK7llQecFwa4PcMrwZl1OJO1dP46SUOHkZ0jgE1V6cQKdhOu+vz21D2hdu5zYJEJuHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYGV5PKr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733855098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nhMPj/ozuoD9sVD9Ow1ZB9+eVVLEWg/CeyeINkPCXM=;
	b=FYGV5PKrpzLzC+7d9HGcuYbihD1d1vXh8WHTkCvA/Vm9TaxpB+koLL5xv49QDOkaxnO1vZ
	rimf/NXP4DydL3LUHWUFFtYS7s/xFHUngoHSMwPPkerOeqqdYYoKnSCtmV5qVMNlFpRNnH
	roXTlr6SR8c0FsA6WiXpG5GA9J4WY9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-mh3AceNZM4KQcfGtpBCTmw-1; Tue, 10 Dec 2024 13:24:57 -0500
X-MC-Unique: mh3AceNZM4KQcfGtpBCTmw-1
X-Mimecast-MFC-AGG-ID: mh3AceNZM4KQcfGtpBCTmw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434f112d83aso26137345e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855096; x=1734459896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nhMPj/ozuoD9sVD9Ow1ZB9+eVVLEWg/CeyeINkPCXM=;
        b=sdPoEDqrTbzHNsyrEU0P+gsNVxhxZ+F+5BDAsMYOYqKEYcpIHbqwEJpwpwJGlnlcM5
         6P4lughig5b07R8PlAIM2qrI/MT7FeNIhfl21w8bjODcCHQKBOlal8m0k9I5jAo8TzeU
         QrkutxtAAJnjCvN5yBIE/+Oq4iWhUHwn7FlUFzx4uFtwBayBHD1L216H/tVtk7mTpyuE
         mSXRIT4bNqxvKGMF1PIX4ihXiUheS9vwztnRxUtmS6lmbgdNEap2H4hxl276Q5S1FZ1N
         xRFST/3aHCxUZ/KnY6teCNjke9iPssfscb+LtVJ/e/lekj1m3PHXujl93ADVC5YotGHx
         RwLw==
X-Forwarded-Encrypted: i=1; AJvYcCW5L21jrpHA161EPuDmHKWbCWuhHE5EqLTbcgtrzrmjcQ1/RsolV1U9E8DDIM5BerinY9vkKqjV1Avtyu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgPX6uDOEBkCnvchVuck9goqrKJ1c63aCebyts6h9aLF6Eo50
	NVIaXbu9W2CuVxWNQBiw8a1kgBRJO5fHydoRmAf8rWjnkYmqsvO+CyZUhNZTIbVb4x3f88WUyJG
	wOWcsjK/aeJ22+GTa5govRxOoHLb063R8DWZi/nhBXN+tgSkxlXBNc28tnGyQDA==
X-Gm-Gg: ASbGncvJwoRlEVhpRKE7x2pjKJwlng0kkV2FExPzOrRMbkyA4kl0EdqASq0ShQQRxkP
	bcBCQl3+uxqEk1fvh8gUGHp7XiimpkKBMgsWwpKrMsJLxmhd8ugEcXR2ojAboq6hde6V3/MfTuU
	wXKrd5iCBpHDtUEWY92t5gMvyI7CBNbqkhvvo8s8aNrzdGN9LHymkK8o9ui3nCIdMuVevCzqRJn
	RZPosGoKxwXFPEc6V3+1Xj1y/D0eM5zDqx/eUm6v10jycLb9WhWlZnL
X-Received: by 2002:a05:600c:3783:b0:434:f5c0:3288 with SMTP id 5b1f17b1804b1-434f5c03c29mr77922955e9.29.1733855096289;
        Tue, 10 Dec 2024 10:24:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGVB33V1sDjcLSxrWLFP1027Q9gKEuHcM2hmoJzAjxmJxwLeK8T8rsrCUfxuLrKG9f6RpLcg==
X-Received: by 2002:a05:600c:3783:b0:434:f5c0:3288 with SMTP id 5b1f17b1804b1-434f5c03c29mr77922805e9.29.1733855095971;
        Tue, 10 Dec 2024 10:24:55 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da11935asm200814405e9.37.2024.12.10.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:24:55 -0800 (PST)
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
Subject: Re: [PATCH 00/16]  KVM: TDX: TDX interrupts
Date: Tue, 10 Dec 2024 19:24:47 +0100
Message-ID: <20241210182446.252044-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209010734.3543481-1-binbin.wu@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applied to kvm-coco-queue, thanks.

Paolo


