Return-Path: <linux-kernel+bounces-282013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419F94DE40
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C952818D4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 19:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45D13C81B;
	Sat, 10 Aug 2024 19:27:09 +0000 (UTC)
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D54776A
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723318029; cv=none; b=P4YXsnBpBxcuaLiHcQ0aUDq8HPEKhwfrCISLXMZZwDp86r8Nswdukj4D8QX4JVE2+2jKObiMRN3gRpjWMqsFJqstkMHTaXrb+5ZxT1KBo1BK71fWKoPNBb7pUWVI7swx1jkI8BccTrQko85I5rsc5WHdP5yrwI55vxsEX3ov8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723318029; c=relaxed/simple;
	bh=01wgOQT9vxaKLoZuw9TsM+NHRt9+1T4JVeIPL+H83Oc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=lDFK7+a82oTOwkbiinGVqyr/0NFiHEnywONbZJr1MniTILjG4Y0qUH9UYgWyftgpb4OduhXDC3PMImCXevnj23Lr8X/jD8hEpv0XNSCEssMX/8Pniu8aGC54eDkHB7Dn+zw1816rH1Olwdy1FDx1GlSw4zawlY+OUKGIgCHs6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTPS
	id clRest8P5kYKFcriUsZlzl; Sat, 10 Aug 2024 19:25:30 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id criSsmMd6KHV8criTs7RWp; Sat, 10 Aug 2024 19:25:30 +0000
X-Authority-Analysis: v=2.4 cv=XeEqz555 c=1 sm=1 tr=0 ts=66b7beaa
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=M51BFTxLslgA:10 a=3I1X_3ewAAAA:8
 a=VwQbUJbxAAAA:8 a=3OOS-fkSXJapXGOR-JsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VG9N9RgkD3hcbI6YpJ1l:22 a=AjGcO6oz07-iQ99wixmX:22
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 47AJPRWV015402
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 10 Aug 2024 13:25:27 -0600
Date: Sat, 10 Aug 2024 13:25:27 -0600 (MDT)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs show actual source in /proc/mounts
Message-ID: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfPT0KhYLsp+U/XViqnCdSjnaHhlPV5KdarVENFWYShN7mjlQAVE7AAecTzHAd0zJMt+Tx2/kpPcbJU4RefhUf2/tjD6yeXkb9RQ7AED2Ld1eWRht9VgV
 j4rZzasPlhXA7cvXGdo3nFEqXEvqczPAHPgHrov11Y3DYcFPi/1bJ+JmIy95M2N+nrsir7wx/uLv/nrKeHSfRycQRNxGy86X7kOUuy0C+Ir62h7fgZi9qj+1
 gQo2afPy8tCSL6KEgjfEPUQ6tcMn/AHiukoEx/27ecHQoFI0LsN17suno0fxSu9IAVKGBV2f5KQawAfsNhnyFBxwRf0kFYmwdZOb+m6WEAK6daSJz87q0TF4
 P7J3yoEx

After its conversion to the new mount API, debugfs displays "none" in
/proc/mounts instead of the actual source.  Fix this by recognising its
"source" mount option.

Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers

diff -NRapruz -X /etc/diff.excludes linux-6.11.0-rc2/fs/debugfs/inode.c devel-6.11.0-rc2/fs/debugfs/inode.c
--- linux-6.11.0-rc2/fs/debugfs/inode.c	2024-08-04 14:50:53.000000000 -0600
+++ devel-6.11.0-rc2/fs/debugfs/inode.c	2024-08-05 17:12:45.414338128 -0600
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

