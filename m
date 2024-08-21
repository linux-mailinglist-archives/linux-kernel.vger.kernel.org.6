Return-Path: <linux-kernel+bounces-295196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ACC95986A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87711F22B76
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DDE1CB13F;
	Wed, 21 Aug 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="thpfgl7o"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5F1A284A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231377; cv=none; b=sXHyzeEK4vMoOisMaS0NY8rS0FrsvA57z+mFUsEWsydhBzsobURrXHc7JIoVu57DlPIE6fwGqRmvcQ6UVbxyVSboy10cEpoUlZs64hD7MPSFJb2dkIlq45/UwpZfm3wRGwpl4hI+MAxkRlOtJ54qZ4I7eJpBiZRcdSTzBYyYjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231377; c=relaxed/simple;
	bh=pscOFGlCgvu/Lb17cAKta+FUDXVvvrtWVkET9SgOfFs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IG+xJEVXKmTq4nUVo/UYGJJcXh8n9Tw041Cbp1p+px4M0vA3wFevoUtrdMwRefW1rZNVflb9O6gOHOU00lBf/nLDaDNnIS0bAFtz5mjS8lZxeV0IdJ57kZwApnZFDvKabCy/wd3LdlDynfZQQpQD47elw54OhsfbKxGyLS8ki5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=thpfgl7o; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724231341; bh=/4m4/zfQ1j7e+NiTLyemBIiB5ARz6PLRUOK09/lohfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=thpfgl7o6LwXROMjm/5oEodK5/L1sx/G1yGHefcT4kRvGWkWboDjxNMxD8cVvbmXP
	 +k3FMv40S6etv/k2vBgk7WXO1wk/6My41apcdXtytCLVe//bwcARGH0DL8Y1cqQy5Y
	 xRbUC6k/XVbSDL3TY1ZkZwiCuU0RvpHUQpUjTW0E=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 239B6218; Wed, 21 Aug 2024 17:08:57 +0800
X-QQ-mid: xmsmtpt1724231337tr87vhqi4
Message-ID: <tencent_A2C892F8065B09AEAEC9AECACC9967FE4606@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeiet7TFZ2QXkgTTQs9GRdWtE8nalB1AXr8z6r/ou+bXkxmF8vB9e2
	 mtkph5/HHAfwpfbYSB8zy1z7nGLXiiAzGx+/mRa5JE1pR7X7TYOFiLagHxNNROetzSfsKOq4OARN
	 GzYeZ76MdjHW+VNAR1rKjHCBDuppWVxRk8JgDd7GGXojHDPOXX72Kv9JiiYeKEW8fRK0FIhExcrK
	 QPJu8eBKbd6Do/HWgQ5peRGbRuttPjCrvJt/4z8g6E21EQgaf2YEIcq2hQuNI5O+M/N8Ua0XoqA4
	 wEdirF2x8bY7FO6gxIJcdhHo9d09gUA3GIwmMshpygL7KSaG/nCU4EywUhlFHscSGkq8LQa8IBAZ
	 UeaukE0lhK2x1iEWR3++4+eqUYA7GQPFM6DQn6tcVvHFpLGeFGkhFPuAmVWxPSDtVoIQIeJkWa4B
	 Bmeer/QvyOHTGtnmbxw5/IgCwvpLwZPTO2goc5ba4W8wC4bJ9Alc21HXxSkO9fGmWbOjsZcJXvgn
	 LXwodYVKAWGlxJNlPBF5fHHCGdMtpG6Bdnf/DRbueZRs0hUCjTkGgJ2xnyHUkXznFai9nrJ4Vqzk
	 UUi2iVGCMGbYWG9/xBSB4qEYVYDLPwc4iK99glbjLc8GB69wXV8p6/9Q6ar85vyOmLC4RfGAH77u
	 xfa+25M4xdrpJ+R7UzOTftW+FVu5UMBUM8uUUIqwkcUQ56l9y5TAvaQNI1m0O5p1aaNC92yIPgDp
	 T1J3F0IjFodOhCBM69kSyactE63vsAhFtZs/fbb8tB0TWeLvSOZvba4M36VhSoz/w1NBogHNYJtT
	 nELrQPsaJqaQfbU7XRg5rXXKIofx6e+6jc06pvOvM69MSWV+LCwwGbwLmPt4IU9Ykz4k8I2hgFBu
	 nx1RuVRxlhjbsb1jjbKec5oX2sqIop/X4KSOH4eIhYnzJmOPznfZzDJZ0Hq43gF7lNSVLtGMGEKI
	 BAbnSSL6es1xSJ8f8Z1v8BQrOdOkxOK6iCKgTrxGU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: willy@infradead.org
Cc: eadavis@qq.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ocfs2: Add i_size check for dir
Date: Wed, 21 Aug 2024 17:08:58 +0800
X-OQ-MSGID: <20240821090857.440326-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ZsSvbDxMtUEHEldl@casper.infradead.org>
References: <ZsSvbDxMtUEHEldl@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Aug 2024 15:59:56 +0100, Matthew Wilcox wrote:
> > When the i_size of dir is too large, it will cause limit to overflow and
> > be less than de_buf, ultimately resulting in last_de not being initialized
> > and causing uaf issue.
> >
> > +	if (i_size_read(dir) > OCFS2_MAX_BLOCKSIZE)
> > +		return -EINVAL;
> 
> Surely directories can be more than one block in size?
In this issue, Yes.

--
Edward


