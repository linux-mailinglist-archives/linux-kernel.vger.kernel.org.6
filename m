Return-Path: <linux-kernel+bounces-240752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D8E92721A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053941C23F55
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005B1AAE26;
	Thu,  4 Jul 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWoleFAn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8816C1AAE16
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083143; cv=none; b=dmTkIZEL7m4pwIdrKBVs5CijnX4vfct+bgDCwo6NXTSh5YX+nsvR3uyhncXqjDSanrCuOT6oLUqjf1J3gCuo+P9tUwYL+GXMCQ+mPj1II6Jz0B+aCJrYR03h3oWIH6nO5rb7ze1vYszYoaEGfQV10qqcAOSWqJp9eBlj7QOx5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083143; c=relaxed/simple;
	bh=0Q6EO1vdcF9wTntyw/kOxb1sPugF8eeMbnBpOrz67mg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UREzOu7KlhxcJuaqDIEOmwlPELZTQJ8GuCLsZBTN5/B+o5bFGGF5mrLwekL0No0b14Y4ekHUo6phv8TftiYfONmOXoU9xmuL2ujeNT8Y6ASYKMFuscHMRsUerKokcqKbVYx+2Nmv9Q72ctIoHNpg7jgKfIvhND52Mwa9Jsd3A3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWoleFAn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720083140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4LDkzy/lYqg24449f+E5MWYyYh8SWKDByuMk65mfLoU=;
	b=aWoleFAnuiqZwpJlgWB13AOAWmwSv1sWUXmKvqRJdyx2iE8bffkc/Hwyx/Sd1NdLXyDixF
	ax5ZkB9M6bEeaLY4oe3Ah3hIJ9esY8ECMCllS4L6tOMIF2nWWwat6/zzIUctkmKQGLouUV
	oEH3/bi3yyhmV7Ud/420GXCgpdnLVEI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-bqJSw6VWNki9sftxVeARzA-1; Thu,
 04 Jul 2024 04:52:18 -0400
X-MC-Unique: bqJSw6VWNki9sftxVeARzA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F96C19560B1;
	Thu,  4 Jul 2024 08:52:16 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.233])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 119D73000180;
	Thu,  4 Jul 2024 08:52:13 +0000 (UTC)
Date: Thu, 4 Jul 2024 10:52:10 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.40.2
Message-ID: <zmx6wo6ottei3znlkbzfsyok63g365t56agyemojzxmpgsfbrr@2tpaszgblugt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


The util-linux stable maintenance release v2.40.2 is now available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.40/

Feedback and bug reports, as always, are welcomed.
 
  Karel


util-linux v2.40.2 Release Notes
================================

Changes between v2.40.1 and v2.40.2
-----------------------------------

autotools:
   - Properly order install dependencies of pam_lastlog2  [Thomas Weiﬂschuh]
   - make pam install path configurable  [Thomas Weiﬂschuh]
bash-completion:
   - add logger --sd-* completions  [Ville Skytt‰]
build-sys:
   - _PATH_VENDORDIR workaround  [Karel Zak]
cfdisk:
   - fix possible integer overflow [coverity scan]  [Karel Zak]
docs:
   - update AUTHORS file  [Karel Zak]
include/pidfd-utils:
   - provide ENOSYS stubs if pidfd functions are missing  [Thomas Weiﬂschuh]
   - remove hardcoded syscall fallback  [Karel Zak]
lib/buffer:
   - introduce ul_buffer_get_string()  [Thomas Weiﬂschuh]
lib/fileutils:
   - add ul_basename()  [Karel Zak]
lib/path:
   - Fix ul_path_read_buffer() [Daan De Meyer]
lib/sysfs:
   - abort device hierarchy walk at root of sysfs  [Thomas Weiﬂschuh]
   - zero-terminate result of sysfs_blkdev_get_devchain()  [Thomas Weiﬂschuh]
libmount:
   - fix syscall save function  [Karel Zak]
   - fix tree FD usage in subdir hook  [Karel Zak]
   - improving robustness in reading kernel messages  [Karel Zak]
   - add pidfs to pseudo fs list  [Mike Yuan]
libsmartcols:
   - fix reduction stages use  [Karel Zak]
   - ensure filter-scanner/paser.c file is newer than the .h file  [Chen Qi]
libuuid:
   - clear uuidd cache on fork()  [Thomas Weiﬂschuh]
   - drop check for HAVE_TLS  [Thomas Weiﬂschuh]
   - drop duplicate assignment liuuid_la_LDFLAGS  [Karel Zak]
   - split uuidd cache into dedicated struct  [Thomas Weiﬂschuh]
   - Conditionally add uuid_time64 to sym. version map [Nicholas Vinson]
lscpu:
   - New Arm Cortex part numbers  [Jeremy Linton]
lsfd:
   - Refactor the pidfd logic into lsfd-pidfd.c  [Xi Ruoyao]
   - Support pidfs  [Xi Ruoyao]
   - test  Adapt test cases for pidfs  [Xi Ruoyao]
meson:
   - Correctly require the Python.h header for the python dependency  [Jordan Williams]
   - Fix build-python option  [Jordan Williams]
   - Only require Python module when building pylibmount  [Jordan Williams]
misc-utils:
   - uuidd  Use ul_sig_err instead of errx  [Cristian RodrÌguez]
mkswap.8.adoc:
   - update note regarding swapfile creation  [Mike Yuan]
po:
   - merge changes  [Karel Zak]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update ja.po (from translationproject.org)  [Hideki Yoshida]
po-man:
   - merge changes  [Karel Zak]
rename:
   - use ul_basename()  [Karel Zak]
sys-utils/setpgid:
   - make -f work  [Emanuele Torre]
wdctl:
   - always query device node when sysfs is unavailable  [Thomas Weiﬂschuh]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


