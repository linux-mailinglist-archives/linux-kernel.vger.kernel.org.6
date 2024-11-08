Return-Path: <linux-kernel+bounces-401312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B89C18AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898C6B2487B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994361E0DFA;
	Fri,  8 Nov 2024 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6XwWszZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A51CFEB0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056585; cv=none; b=A1q3uMlaRUo1wCoF8JRxZYM8xN48E744pBoYAVQMPf9L+VLZKY9c8mnqYoasbqkqe1iVRhdaGDwDDGcwSjgmFD+yylV4vYqHB5CbZ0TDC6MjTlMs7woV/P31Tgxp1nh6vGQvN5fpIK2dmE+rsk28SU/5/xEHCkbOKW0T+1+6fuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056585; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urDPioyGM4xCxaeYAijDj7WyuXhcj7Ixf1jPxwOHB6JnwoEdYACVhVAlEbwPDP3hCfWGk4o8SZxMncdCtpLQpz6MBTCxCAD2qF8MebAPbVoTVHllt/cnHMAx9wPhrnB3pd5gO3P5Qs7WhAWRPfcw0yTM0ZMZSqAJLFYEszgCLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6XwWszZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731056582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=U6XwWszZvXqzabHKqiThXxPNMgJi61LIPg6JjK1WXmBDpo6xF6Uh0nHvayrD1sZAZjwEPa
	8u5zHv7y9X80b4kIQeGTTyx00ZGXPsnhxgFBlLaVTiSXooDm6Ch3j4j8xzg9Wg2cQmgLSd
	NJ+ZL/0ugwBCtrGKdxjVaS+LWitt5sk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-iCne93DxN2ONu9BrsURPKg-1; Fri,
 08 Nov 2024 04:02:58 -0500
X-MC-Unique: iCne93DxN2ONu9BrsURPKg-1
X-Mimecast-MFC-AGG-ID: iCne93DxN2ONu9BrsURPKg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0D551954128;
	Fri,  8 Nov 2024 09:02:56 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08708300019E;
	Fri,  8 Nov 2024 09:02:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: John Sperbeck <jsperbeck@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: use X86_MEMTYPE_WB instead of VMX_BASIC_MEM_TYPE_WB
Date: Fri,  8 Nov 2024 04:02:51 -0500
Message-ID: <20241108090252.5439-1-pbonzini@redhat.com>
In-Reply-To: <20241106034031.503291-1-jsperbeck@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Queued, thanks.

Paolo


