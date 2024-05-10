Return-Path: <linux-kernel+bounces-176258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23858C2C19
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E162283C03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4E13CFAE;
	Fri, 10 May 2024 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WB5KHMzP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17E13BAFB
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377769; cv=none; b=Z8gCgWeW8Ro4ypI9+IabcPuxMYY+0EdIvr+/jBvZJwP3FvXxQTz3CMsp1GaIuLvYFm51uM3SwSL5o+YnIZK/CTNjmpuwtJ5quKSp7NRRZgVZSaly/6lq0MDPi3Z1lQW3ePx+wUIyCRnxlc6+4GzRszqhfpxj45JlYY98LC0GmW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377769; c=relaxed/simple;
	bh=+nNK4hww+ycl2EEjZu+DB3rnPniLjPproECnJoapLfQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TUWhr5OCcVreutXd6FUDbVEtUJAXMl7WejmBwDZ7tpamm2UKGTsMJbJHmdMMO0fSDPS5ixTQ7tHsij3NCNo9wLxR16njb5B+yEF7XmdumBuIqyFqrPiFFSKWMd3CRF2LmD/EPqZ14cL3kw6B0CsS/SB0Gqyo2saRmUrb2tQLmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WB5KHMzP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715377766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Oowk90sqfml4YNrnonG1SBezdP9RE70uhV4ktZariMQ=;
	b=WB5KHMzPp8VrIx7PFSkt0cOeV++qF/vM1L7PPuiJlt5S/aBjLt9QrPYLTN5yiaJujvxNzs
	gygdW/XX1zu28dqQ0yMk2IVqY15YD7KOGKjpbEkLSp+YxKJk57XwTbVVwmsHypNC5F+fLh
	36ddKlz7Cdx+YwWLaE2ky45oGhfLY4I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-mxGkenmZNwWvFjHZ5uqEkw-1; Fri, 10 May 2024 17:49:20 -0400
X-MC-Unique: mxGkenmZNwWvFjHZ5uqEkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B3C9185A780;
	Fri, 10 May 2024 21:49:20 +0000 (UTC)
Received: from localhost (unknown [10.22.33.191])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2F6D96339;
	Fri, 10 May 2024 21:49:19 +0000 (UTC)
Date: Fri, 10 May 2024 18:49:18 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.216-rt108
Message-ID: <Zj6WXvAhngh5-Iyv@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hello RT-list!

I'm pleased to announce the 5.10.216-rt108 stable release.

This release is just an update to the new stable 5.10.216 version,
without any RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: f0ba9d06ef6b1edce9a62b662415d70e000efdd8

Or to build 5.10.216-rt108 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.216.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.216-rt108.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


