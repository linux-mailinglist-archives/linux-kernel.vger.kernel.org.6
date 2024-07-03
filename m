Return-Path: <linux-kernel+bounces-239429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01522925FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DDB286C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D3C172798;
	Wed,  3 Jul 2024 12:09:41 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD38158862
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008580; cv=none; b=RYzkHryHPgyu1iVTgVIjuDE9vL8u2s46WwuXoRMxnKKFSnOIyhvKvk4XIO8yehV54D7IvCjqskBi7sQpVIOz/Pjr1wkKSzpUoXXkX1yyB867+AmgfcKQ99JTFPhC9O1gmkSMAXcnit7VhtugWtedzN6sNnhwvZJMyNcHw8QgEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008580; c=relaxed/simple;
	bh=2aCGqVBTsyNtk/3i1tyo0SCfBtdeq6gmjEv8SUq1xp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQ1WwoS2rTP7R9JaaVCrs6JPHDzPeFsA4xndBLFeVeVtJkNdMQce4uAXDqcTXty2AZ4ePlEBlSm/NBu3BTfq9N8fUzmAsUeB7HuFHEo3574maAeqJY8/j2IWVPC1ipWl53o5+NYwqGKkd2qKk7BmdxOBAqKpNCha51sEwQ2kRZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.67])
	by sina.com (10.185.250.22) with ESMTP
	id 66853F73000021A1; Wed, 3 Jul 2024 20:09:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7016087602759
X-SMAIL-UIID: 10971053EF6F4499A16CF27989682586-20240703-200927-1
From: Hillf Danton <hdanton@sina.com>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com
Subject: Re: [PATCH nf] netfilter: nf_tables: unconditionally flush pending work before notifier
Date: Wed,  3 Jul 2024 20:09:13 +0800
Message-Id: <20240703120913.2981-1-hdanton@sina.com>
In-Reply-To: <20240703105215.GA26857@breakpoint.cc>
References: <20240702140841.3337-1-fw@strlen.de> <20240703103544.2872-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 3 Jul 2024 12:52:15 +0200 Florian Westphal <fw@strlen.de>
> Hillf Danton <hdanton@sina.com> wrote:
> > Given trans->table goes thru the lifespan of trans, your proposal is a bandaid
> > if trans outlives table.
> 
> trans must never outlive table.
> 
What is preventing trans from being freed after closing sock, given
trans is freed in workqueue?

	close sock
	queue work

