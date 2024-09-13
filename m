Return-Path: <linux-kernel+bounces-328525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4B597853D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11B4B276DD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E4D7441F;
	Fri, 13 Sep 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="KD/MmOtu"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021AF55898;
	Fri, 13 Sep 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242971; cv=pass; b=i3Bwvegrl0+2xpbCNyece26zX/hgXXMCpKkau5SOF0tsQykmn90Evwpal7sOBSyAu2C1Ev9omlcKFDkhmiUz7wn007zfHtFgDgoVF/1h8LlHCYM+OHH/q7dbRH32ziOCOGI2hiCoB5ef5BK15a5IS8fwBLJBMj5BNixE6WIHRBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242971; c=relaxed/simple;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k9xCXqB8/C0MROERDbU7HhJAZLl7YrA1tRVQLVNQ1LndTVm/SN79yQbgMOZFdEFVmRotD8YrUngwbwYDEirSr9cUY2az/+Sf44XAOoU8/dh53WJko3/hJo09zazmpt5/YYnukuL3yOnLPdF0jvnxbFZZ/8F69PBfkTV0b2Eq/BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=KD/MmOtu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726242941; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VBFyo4FXB/M1BvCJm8MJRMMpyZCxQRzY2QJhxdoF3BzEkZpw38PTo+9cpuR+8V5F7IwGcRzm0wdE6M8GMPHewo/44qnnPVxcXsniOJhfv6BvZjTJFbcG7tztmC+ax8mVG+vRtp8SfBYDi/eQ9nQ3chkCDXKB6MsmICtwg3MExpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726242941; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
	b=Czxa0ajItnHNhqwKEpor8RmcIhiFRNdNPw1CTToBBw5AkwFWWfTBUhpsgkYTCzKyWuVnBGYb8sDZu1boazHAI95L/Y0Z+Fh6AoWFERczZGr/0qG9mRbjLmlZSWe7oUIuZnvUs/z4pvg6G8z/Qa46zTTHcU1SKEmbZwmrE1avjfw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726242941;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	b=KD/MmOtuGLzG5UFbnZIFDRXMLf1YRubIw9mkc/L7V24XCymtbiRi50QohjRAzBj8
	jgknl2P2P+EbhyqeJJlzd7mZp5hsTIIx45WjnPTyNwKaPDSC5IiGnDkeTN79KT+bV7e
	wjXzOFQiUWITS4XY5MnvhkQxnP+y1/aN7NPkdU3s=
Received: by mx.zohomail.com with SMTPS id 172624293908388.87809748425764;
	Fri, 13 Sep 2024 08:55:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v5 3/3] rust: sync: Add SpinLockIrq
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240912190540.53221-4-lyude@redhat.com>
Date: Fri, 13 Sep 2024 17:49:22 +0200
Cc: rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>,
 David Airlie <airlied@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>
Content-Transfer-Encoding: 7bit
Message-Id: <DFB9CE88-A79C-44E5-8D54-D32521CCAA85@collabora.com>
References: <20240912190540.53221-1-lyude@redhat.com>
 <20240912190540.53221-4-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-ZohoMailClient: External

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

