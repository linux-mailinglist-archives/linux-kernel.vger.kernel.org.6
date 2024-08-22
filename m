Return-Path: <linux-kernel+bounces-296999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FBF95B1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6260AB22078
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA48175D39;
	Thu, 22 Aug 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kHkfvzd+"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5434CE05
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319104; cv=none; b=XCwGqm8tdmajZNxemnvYAcR1ra0TXiKfRzPNfbTw3wnSlfvJ/AVQG3rsr2ebXfkeCEmWUzAQ8eI3SjOR2alYMvplkZTDygDiQ/bmFRo3dU6rQ9QAjSIu1swnLnQi/XSNomAlk2XAAcjURc6OM8U18v3rDyfTw6qkFp9agvFWJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319104; c=relaxed/simple;
	bh=MdsOgSn+bfJUOUiC5bKnNP/9tEqRiC7+UHP3jTPUKZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+q+A9hQky5+VI2xyyPEl3prwkCuR/GZodOappLLaQKzy7I6TUNq4B2o6karWjVcyk8Olbr3zawnjkBWabZIct10/cngBZvKQGTv+3IBRuHivLAxzwFW9mrhL8hQESTzgoJeVfOPCAjXniAylINHR43XCoOfMBmtjNjV1/S/IrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kHkfvzd+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 05:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724319099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MdsOgSn+bfJUOUiC5bKnNP/9tEqRiC7+UHP3jTPUKZ8=;
	b=kHkfvzd+WDHZyx7PZAaW0iSsNhAawP+ASRv79cC8YcNp0unsczES0JVwWzNn/3cQGYRj11
	LqSOS0c3FK1FRKh8TTE28w666Txb0pWaR38Fymfey7aDfkWi2UJKQiW197OOOs2wEkp25f
	Bb1pXbzAVDcmNVt69aa3MB/FCcFyBOY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+5c0423c85f295891c7f7@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in
 bch2_alloc_v4_validate
Message-ID: <docripdcuhp3kr2l6r3lglhns777xtnblwzuoqxu6n5unk4unx@nm4777ttnrrc>
References: <00000000000016f0070620418323@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000016f0070620418323@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix compat issue with old alloc_v4 keys

