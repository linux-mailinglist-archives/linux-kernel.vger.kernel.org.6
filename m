Return-Path: <linux-kernel+bounces-574258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDC1A6E2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D395168046
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF636266F0B;
	Mon, 24 Mar 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3I6VEgm"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F4264617
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842443; cv=none; b=mom8qwXaAcWO6Pc7NjXJpc3+dyrV++njV5fFCFS/Ih0k7fhe0cMhomi73pPmbMm4Ql4rDxEOv03O3vNcyExcrxTP6Gm8e3s8ouUdapbfCNeM7E6m2TR7BSSOwF3QyzDllEdasovuBK1pi6LgETA/gA6dPVFwOCwUs+BO9XqRzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842443; c=relaxed/simple;
	bh=5Oc9X4WPpkb0I7xxxkTExY9Kqtnuab39zq/DpuRW+9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BwXJz9rRF9ZVSTvG12I4WFoIX4ALZxoRoErocLR3/hMl8d+0Y0guxRMgONcnap44ryqswG7/hLQ/2go9DHFi+E14eZNolSOPtVyoOxFZGSYvbtX+t+c46etRaQX4nX5EpC6IeTIWPEucAYPLljrpudw3wSfmM9Qzb2FLxsXN9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3I6VEgm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225107fbdc7so79052995ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742842441; x=1743447241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Oc9X4WPpkb0I7xxxkTExY9Kqtnuab39zq/DpuRW+9k=;
        b=l3I6VEgm5q85svKuNm4IPcpQV6Y0172z7VaptWLIgwOw47J88oHOvehcuj5vXp98F0
         c8kECPLKfCcCkmwJZvVW76OA8YgADH72/j/Nn82msc/beO8vkbQPSVqC1ZoWf9kcvI54
         D3kLfIMiNB+vY0saZsN4JPv2i+6ocy9rUUjfnqF1GlnQ/kNPSuHY68dbf0rV7f+lvZzA
         oQIjHPpzJa3IotDZpV0GnDuPVmq6ogNot1Deni/o0vJVkWBHhVK6JPjuhZTKtUREwxw3
         FBlZkR4wnjDtXtOnH9SZgkqsyq+DS5FEhpfzmwG2kEQJsRt/EROFnuiHErNuZqmOh3Rk
         PQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842441; x=1743447241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Oc9X4WPpkb0I7xxxkTExY9Kqtnuab39zq/DpuRW+9k=;
        b=TRrJv/CWylCpnWhxkmet1StxTQNgcanxt/JiYyOl+Da4AMaTlr8IzU9L06aq9IFNGk
         6Xa8ghe7bs5/39yULfd0G/iAiRgw/Hlqoo6d/H8BpkVLw3G28LsX3d4BORK4F/67RChj
         I1Vs6Ej8XyoXhbug/E/yiAJRdQKX3LckuVtBcA3PzNjufx2thv0teP5pPXPFZivU2GcT
         poq3d38+TJnv/vmDKCL0PI5OwLEWNBYqlgUpZ5cU2t2KVS3GjduyZ7s5EVfqQwe0VGIi
         5e+MEGJha1AgMNHewftgyD7jMmVeCjTAZmDnUrNm/5sNPOvqrI1g5OC7CyRxBAkcdx8u
         m0DA==
X-Forwarded-Encrypted: i=1; AJvYcCWog8Ym4OQJJpRVqGd0l/msZQKvln5o3z2JEMWWA+eREkziYhcAB4fsSr0DUvg9TvIWS+Yt6F3RXgg6iFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKf12mfysIJeOaHI9PMelM4LVYtY9A1cWqUebOa5a1kFIJJkA
	3N5ISOfb0yC6ap7BPFb/2yLQuT25INSThlWAjcNPjJtUrRuvq50v51bcb8Lpl7zPp2SFsJODfl1
	GOj0CLg==
X-Google-Smtp-Source: AGHT+IFgmKsprpaGDjxSOAFPcgtylxDFAlGJWR3zzYK2eH1W43TjKeWbEuCfuwWXukUdHLsJ/AaSlcsX4NnQ
X-Received: from plj11.prod.google.com ([2002:a17:902:c14b:b0:21f:651b:6fd6])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c9:b0:216:7926:8d69
 with SMTP id d9443c01a7336-22780e26127mr200986085ad.47.1742842441044; Mon, 24
 Mar 2025 11:54:01 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:53:53 +0000
In-Reply-To: <20250228014416.3925664-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228014416.3925664-1-vannapurve@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324185353.1974105-1-afranji@google.com>
Subject: Re: [PATCH v7 0/3] x86/tdx: Fix HLT logic execution for TDX VMs
From: Ryan Afranji <afranji@google.com>
To: vannapurve@google.com
Cc: ackerleytng@google.com, afranji@google.com, ajay.kaher@broadcom.com, 
	ak@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, bp@alien8.de, 
	chao.p.peng@linux.intel.com, dave.hansen@linux.intel.com, 
	erdemaktas@google.com, hpa@zytor.com, isaku.yamahata@gmail.com, 
	jgross@suse.com, jikos@kernel.org, jxgao@google.com, kai.huang@intel.com, 
	kees@kernel.org, kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com, 
	peterz@infradead.org, sagis@google.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, tony.luck@intel.com, 
	virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested with the specjbb2015 benchmark. It has heavy lock contention which leads
to many halt calls. TDX VMs suffered a poor score before this patchset.

Verified the major performance improvement with this patchset applied.

Tested-by: Ryan Afranji <afranji@google.com>

