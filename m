Return-Path: <linux-kernel+bounces-217689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10E90B2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB0B284ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA2D17BBA;
	Mon, 17 Jun 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sTpJJ5Aq"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4181175AA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632891; cv=none; b=Y8I+bR8wdCpLb2i16bqqXuUZnPp7NPRyRhvBgliw2G4hvpyeZ6LS4/8cMDgPAT6GUpjIsvCjsB26z1CJSPF/1XUtdUagHVIFheApZSTCd5r2GBQ+aswD3gQwAL80gFATil9wPRVfaIjNgZFrWAXXd7+aySoBI3qBJnWGV1MhkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632891; c=relaxed/simple;
	bh=Q1Zurbia1cZXhHJODYajoy72UmkmzSWkLzvC519uJwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KahPF4XmTpbUR7dLHnL5r14BYnpAXPl08pk07067dQ2GyMDza8AtOwpv/I5mqQjVGASHS5a0hPWv2vuVkCZqKijSVvL5+PyZHQB6ZVmJzB0mZ2S0HTW27Ej5LuKuovscDE8TOlggOmOGcdV/3dm6TKlTtCWu0k0xX2zWDszrXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sTpJJ5Aq; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+a7c01586b9012e998c07@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718632887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1Zurbia1cZXhHJODYajoy72UmkmzSWkLzvC519uJwU=;
	b=sTpJJ5Aqfx2HHH8pk2CkuWs037s6CVNvkWeWmX8mjnlbaRUQfYbW38qK14LEkoeZYxv8FP
	pjQtjrBeLnBerS5W1AOqWL6ORJQm9LSSdTEeDUggoaF1749yKYUAw/tJyRhEfAwcSoMxy0
	0tC5YNPD2AhfYGF3bDNWcW3rT+cPjDU=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Mon, 17 Jun 2024 10:01:24 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+a7c01586b9012e998c07@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] general protection fault in
 bch2_fs_btree_key_cache_exit
Message-ID: <k5jsfjtel7iscnmt7zuto7tzlysfnreqvp6fmjz6tkipywmkqp@4wvhasubevv4>
References: <0000000000001c53f4061ac0a03c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001c53f4061ac0a03c@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix early error path in bch2_fs_btree_key_cache_exit()

