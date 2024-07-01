Return-Path: <linux-kernel+bounces-235780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF591D990
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838D9283F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2F78C8D;
	Mon,  1 Jul 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XsQKAynZ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542EF41C92
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820955; cv=none; b=KLls0+dPuQ8MYqNX3Z361e+bFcrKK6S7L6ngnWDpFkQRCb1Arpwx6TgOmI1OkmFH+MxkjzQbtNuY3e2iUCD39ierIYhUZIDHohdM5O44soTulf+/AlyoX7zbfBhzQahpQ1CyZTdl8gJ6lUPaWKIg6f3i08jQbMNsatM+AfXsTvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820955; c=relaxed/simple;
	bh=PBSMLOm5Po8X5BwRqt/ewbQVdKOLBiM1iMUfzgSaeE8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qoIRJuMGkJO7z01rlMGtJdoCCPJ/JLbRxDInuLTpCsSR8yB5tn2i+nsT+qFdbDmQ3Pu7KWgCR+4RXKaq11j9UX85X+ECseZJbJrIzEf8dmzh5EJfycP/ygbKm036AsEZEwSr/QmZ+1IJxTOVN5i8jIILY79zwiL99RMlAL++ZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=XsQKAynZ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 46181sW3014026
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 1 Jul 2024 01:01:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 46181sW3014026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719820916;
	bh=PBSMLOm5Po8X5BwRqt/ewbQVdKOLBiM1iMUfzgSaeE8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XsQKAynZfzx02V+lKhBtRhb5pwyLodkc9VWPdrFSU1ivU8o0L5t8TcMOgA3/ASIPG
	 WnYEC7tMvBBtODiXwfjNFupzSOnuL7R+iYQDff/yutQG15niID5UQX+9xU5aRXvJSz
	 kblOy019gXRmPniqGTvzicvmed6JqBIzX0TPQoPqZ5H7ZsSJhtBWun3ocVbfBbGgUk
	 CSyJcpdlUo+f3MI2dtpOxseZ3v7OZEMp8ChbKrbpUF0+aY7+3cEqgt1uKM7AQ94ON7
	 43SJhs/fiMEhkmtFmDQ8YbPcOFsnkXXfgraks6G3MR0c5KX1ZhGuKiccbK7Vg9fCE9
	 uHKwVs0suHCFQ==
Date: Mon, 01 Jul 2024 01:01:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, brgerst@gmail.com, chang.seok.bae@intel.com,
        jgross@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_5/5=5D_x86/gsseg=3A_use_the_LKGS_?=
 =?US-ASCII?Q?instruction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240701064002.GBZoJPQg2IXSCRa4sN@fat_crate.local>
References: <20230112072032.35626-1-xin3.li@intel.com> <20230112072032.35626-6-xin3.li@intel.com> <20240630160448.GAZoGCIHXRuBY8sLqW@fat_crate.local> <3A846C73-305E-4C55-B846-AC00657BA95B@zytor.com> <20240701060841.GAZoJH6XpJz6qyo-Lr@fat_crate.local> <38C69EA0-DB74-4D2A-ABB5-CB3F1D31FB0C@zytor.com> <20240701064002.GBZoJPQg2IXSCRa4sN@fat_crate.local>
Message-ID: <2B27D0A2-B1D0-4347-8587-DCFDB05BF683@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 30, 2024 11:40:02 PM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Sun, Jun 30, 2024 at 11:31:42PM -0700, H=2E Peter Anvin wrote:
>> Yes, all loads into a segment register are truncated to 16 bits=2E
>
>Right, but are we saying that somewhere explicitly or it is too obvious s=
o
>that there's no need to?
>

I don't know=2E It is stated in a number of places, but I don't know if it=
 is explicit in *this* specific context=2E

