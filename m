Return-Path: <linux-kernel+bounces-292316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A06956DED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BCF1F2210F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D74B17556B;
	Mon, 19 Aug 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRnvugbn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17E175570
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079318; cv=none; b=rSI9mUSP9099e+p2VdYrVX8Ogc/N/PX7UZQYP+5zuMELGdU4zSOP4kGlryuBQtoaA2OTQiMd1/l4pn7xa8gWRJ3B8HdkR8DCMHdSXsWNs+XCKOZffDBHaP1Cbv5cKNUTt3uiRzv1XFM4t0WN7WCl0KBq8KxSXUgvN4PBgBWjQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079318; c=relaxed/simple;
	bh=EowreNZLQ30N4cVY10ETji3j3fdTviu5kI0Pw22l/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IR8asiOWHMbehrAm6jruB9oFWla6ZraQVqSUe5wmZVykraRt93ltljOD3AcSnU2pmmyD16QIVqGKmRTzFa//neAl6z8qB/QdS8oubjPhWcgzvmzmPJgruQpndt2h7izboFVk2RK4/51LQk32zYpmOobE9WQuSm2HuB5pHXmIBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRnvugbn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgjZO4Zyjz7laVnuZPF54UYEyobsvNSUm+pwm24uBE=;
	b=VRnvugbnCddtbHKOwxAsK8/UwxeEMivf1O2h+NYHca9sEltKqUWsP0WhFI5Wvkx2c3S2sp
	FGmFnQPqmLtA3ZbL+STKCV86TK8tgx3vuuap+QuOu4byzMoOorzkgiUtIufmx0nXHWUri4
	yGeDQ7rtZaFDlkFY6AgjFPbnT26VrrU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-Brd712sEOlOpIfxBr1n9_w-1; Mon,
 19 Aug 2024 10:55:10 -0400
X-MC-Unique: Brd712sEOlOpIfxBr1n9_w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CCB91956095;
	Mon, 19 Aug 2024 14:55:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75D3819560A3;
	Mon, 19 Aug 2024 14:54:59 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFCv2 2/9] efi/libstub: Complete efi_simple_text_output_protocol
Date: Mon, 19 Aug 2024 22:53:35 +0800
Message-ID: <20240819145417.23367-3-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Some uefi applications e.g systemd-stub uses more members in
efi_simple_text_output_protocol, hence extending its members as UEFI
specification.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/efistub.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 27abb4ce02917..a075d327a11ba 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -506,6 +506,13 @@ union efi_simple_text_output_protocol {
 		efi_status_t (__efiapi *output_string)(efi_simple_text_output_protocol_t *,
 						       efi_char16_t *);
 		void *test_string;
+		void *query_mode;
+		void *set_mode;
+		void *set_attribute;
+		void *clean_screen;
+		void *set_cursor_pos;
+		void *enable_cursor;
+		void *mode;
 	};
 	struct {
 		u32 reset;
-- 
2.41.0


