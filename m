Return-Path: <linux-kernel+bounces-307980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1F49655DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC72283ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB83713BC39;
	Fri, 30 Aug 2024 03:46:35 +0000 (UTC)
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8E1369AE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989595; cv=none; b=CJcSRdWlt15LRUWGQnG6H46+6c+i1cfiBm3MHxcPP/IYJkZb+KRQ+ZUycvZbx1O0ucy5Bnp69qztuuWNCIQks2iU9ngfZZKFWcwyeZ8RIOXNQbk6uqW89UggcE3GQS87TpRM/yDzysGoaDtVqLfohBX/fYQrKzN14y9NYDo7Q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989595; c=relaxed/simple;
	bh=I4MLJvPcC4ROIRlHe9VBbeY/xKuQDgMDbge5iwTw77g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Buzl2nc1GOiac4js24Md4leuO9pmRMFnAF+tOF0N3WUz9G1SIexqKP8tfFDSIsFFLj+OSESfHSzNMJ2K4WXfi2o19y6FUXKjEy62rMREps5GjGgXQqMCzHsq2cFrl+JYjBzmYeN/3BFsfC4NixCtRFW8VrIL1N5Cd7eBptTTUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTPS
	id jhw0sMAFL9TOUjsZEsP8tg; Fri, 30 Aug 2024 03:44:56 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id jsZCsRJ7vE0IVjsZDsdo1K; Fri, 30 Aug 2024 03:44:55 +0000
X-Authority-Analysis: v=2.4 cv=cI9DsUeN c=1 sm=1 tr=0 ts=66d14037
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=M51BFTxLslgA:10 a=3I1X_3ewAAAA:8
 a=VwQbUJbxAAAA:8 a=Z7GQwIsQ4rWEbV4-UEIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 47U3irgA024918
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 29 Aug 2024 21:44:54 -0600
Date: Thu, 29 Aug 2024 21:44:53 -0600 (MDT)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: Eric Sandeen <sandeen@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs show actual source in /proc/mounts
In-Reply-To: <alpine.WNT.2.20.2408181925400.3116@CLUIJ>
Message-ID: <883a7548-9e67-ccf6-23b7-c4e37934f840@tuyoix.net>
References: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net> <2024081303-bakery-rewash-4c1a@gregkh> <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com> <alpine.WNT.2.20.2408181925400.3116@CLUIJ>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfHqC1pKhAmpRzafGTDNTCvTxtMaT9ZLoDz9zbGQEhGEAY24DcwLcEe7UViohuEmlhDsTyFo4jDBmYR1U9PL8B0uwdZexnI4O7t3pwImtYOMcUboL+F6i
 5dar6TgdOUtut6EvARwWeHivTqkmD2Y5f9AJ516duQ2T1Ys+gaIVTQjGWaNodbqB0XAMK5VgZNVw+57JWO1Go9Rab59PfMN3vGM4Tr+wqPX1y16c5PY/hui3
 1kCK8tt4WHmQMBqc6hfjo9CoRGOEqf46IcM6wsAlX/5zfaNi1kEZrUemrMJXmvnhGK2TIf3Y/lASpP9WWqXoBjLoPwT6zLSZo6Hva7aMfHdZ4dRrFp3qitET
 9GniGNjG

After commit 0c07c273a5fe ("debugfs: continue to ignore unknown mount
options"), debugfs displays "none" in /proc/mounts instead of the actual
source.  Fix this by recognising its "source" mount option.

Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
Fixes: 0c07c273a5fe ("debugfs: continue to ignore unknown mount options")
Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers

diff -NRapruz -X /etc/diff.excludes linux-6.11.0-rc2/fs/debugfs/inode.c devel-6.11.0-rc2/fs/debugfs/inode.c
--- linux-6.11.0-rc5/fs/debugfs/inode.c
+++ devel-6.11.0-rc5/fs/debugfs/inode.c
@@ -89,12 +89,14 @@ enum {
 	Opt_uid,
 	Opt_gid,
 	Opt_mode,
+	Opt_source,
 };

 static const struct fs_parameter_spec debugfs_param_specs[] = {
 	fsparam_gid	("gid",		Opt_gid),
 	fsparam_u32oct	("mode",	Opt_mode),
 	fsparam_uid	("uid",		Opt_uid),
+	fsparam_string	("source",	Opt_source),
 	{}
 };

@@ -126,6 +128,12 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_mode:
 		opts->mode = result.uint_32 & S_IALLUGO;
 		break;
+	case Opt_source:
+		if (fc->source)
+			return invalfc(fc, "Multiple sources specified");
+		fc->source = param->string;
+		param->string = NULL;
+		break;
 	/*
 	 * We might like to report bad mount options here;
 	 * but traditionally debugfs has ignored all mount options

