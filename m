Return-Path: <linux-kernel+bounces-182946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7068C9217
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CAD1F22274
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67E6A340;
	Sat, 18 May 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="p9pkjPzR"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1226A325
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716060409; cv=none; b=Sd7TFjIgFTzFAzDQa4FY01NJBQIgUiakYgSXsP9W7fnOzJ0dkcBVaWJ//PcDnakd9JuO8PT4iGzAzZ5QajVShHylQk21YwSfZqsB/YJdXqTQehD+53qaJPOb8HvW6OcGWYrhTqYvY98J/M2INy8b1jFqd5jZ5k6WfJErVJD5PhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716060409; c=relaxed/simple;
	bh=jOuQ5uZjSUgcbnmh6vGDVilCcRsMB9GTgJKB/mLHvz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JBpqUkZVItAJQoN9q/1gFJZz0gDLl0K+ASJfcXkbJ4avfcB5VBiO0/1r1U68/6Gl9RQv7RWmki5YndcycqnNUuDpHkbuH6M+97chJ5uXZwwC5u2Xk43oGUyWLHsAn8NW/znqyngQiloMTwLLS3CNvTPm0E8mRslav17e6LclLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=p9pkjPzR; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id E487C407851F;
	Sat, 18 May 2024 19:26:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E487C407851F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1716060403;
	bh=jOuQ5uZjSUgcbnmh6vGDVilCcRsMB9GTgJKB/mLHvz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p9pkjPzRYueAW/qA9RLCr9VyLG0JUvqnZMAeuYGEveDyd3SrHjHE+OgF8Fk78so/5
	 Yu0CskVgF7YMBxcx6/tyX09Opr7VzZFDnDMsEA2DqbDSNceQ0iL5l5Xbj21J5XCK7U
	 1LT5COj5QkN5hurI6MDKVAOHWbjgK419mQ1J81fk=
Date: Sat, 18 May 2024 22:26:38 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: syzbot <syzbot+f516089d7815b10197c9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mtd?] WARNING: zero-size vmalloc in
 ubi_read_volume_table
Message-ID: <20240518-f6ee39c99afd546f45cc692b-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000a7f84306150bc9d5@google.com>

#syz fix: ubi: Check for too small LEB size in VTBL code

