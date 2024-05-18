Return-Path: <linux-kernel+bounces-182928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27BC8C91D4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B314EB212F4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9204D59B;
	Sat, 18 May 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="lvfpXwX6"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2228481D3
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716056408; cv=none; b=E18G/UyMLqBIy8nVX3brYZDrNntlLP1KR/TLxNxa4rUAwgJt/rFk/VhJcYl1br47LchLgKXQgVZ+1ef+txeyzlfGM08rcXbPHjUNgWapek+insvqTKG3qEBw1S59TvH/uEqor03/sDoAauX7CNT2RrOFtLPC4JGaEc6ArEznSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716056408; c=relaxed/simple;
	bh=A/EoPBeMqtNANCdKY65Ed0ftg91GiZJQ+YgtYe181Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HSkjWf0xN74UWkpv04gVdYXy5ZMwDCqXquPJMNhhRbOO1OINnZLMT5WNVM02cSazjehu1RmPLGdMdE1GCKWoVEegSLwLFbPo2AsW4bPbjqfgZhS93rC7aCkVtyp9dq9QoQ5QfIwosG++D7r4npy7d+mt/H0A8B86QlaxSP7u3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=lvfpXwX6; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0 (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5338F4078517;
	Sat, 18 May 2024 18:19:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5338F4078517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1716056393;
	bh=A/EoPBeMqtNANCdKY65Ed0ftg91GiZJQ+YgtYe181Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lvfpXwX6nqvtMXO/fxuc8UoVzhOxUZekg/PFrhiut7CwCrRuGUc2lvX/4TOdAmCAa
	 5LeA/ismKkTT+Jo6uU3zL/b6XWYPnSLxAlOzB8u/ZrQ7+ch4IMg1oQUPwiHxDp5Re2
	 hjiZ0r0rPCyChPphKjknmWuSMlzVZfdHzYgWZDNI=
Date: Sat, 18 May 2024 21:19:47 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: syzbot <syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in __fput (2)
Message-ID: <20240518-f07e7cf8430d8fe22f5742ee-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000898d010616c1fd03@google.com>

#syz fix: epoll: be better about file lifetimes

Links:
https://lore.kernel.org/lkml/0000000000002d631f0615918f1e@google.com/
https://lore.kernel.org/dri-devel/20240423191310.19437-1-dmantipov@yandex.ru/

