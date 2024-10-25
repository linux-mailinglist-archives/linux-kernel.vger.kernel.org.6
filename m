Return-Path: <linux-kernel+bounces-382613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9E9B1110
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C495FB220C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD341223A40;
	Fri, 25 Oct 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ikr7ItYi"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBCE21746D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889380; cv=none; b=X7r5U2T0KNMh/X+8If0kxhaCwIl9x8vWbvYV8J2+ZzrV4l1aKE5Sb2IFzisC2bM5WwV6FCyaEqiX4CfYJBa7qwAz/nWyktqFfMT+jm/8K436Ct+myCfWac6zVWandp9vAx2F5qmMomHr/g3ABV+PJOHaLjJghwU/faIBxGgMPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889380; c=relaxed/simple;
	bh=LEFNEBRsF3wSEaFE8p7mGPUOPvhHFlmdgo14J6EAyJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ye6mDBZKWdFMN9a3GKlnyN3q3QV5lX5jPB4QOn7dW0IziZotjG/8tn9uc7oJyQUe9d/oMPIAUmGU10CDsD7117q5q46KZpbgkj9gqn2M4sgNgkqy6K9UgVbbV8L2rH6Pui79o1UaX8DHdvzu6LUHcNheAlkfBKbX4R5bY6HMGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ikr7ItYi; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b14077ec5aso325892185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729889377; x=1730494177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HaNSsC4KUZ64ui98jp8meP1eBKQiBOs+wvC+63/8s/o=;
        b=Ikr7ItYiU1w8/xUdoib+SX1PbYqORmyT+z/n6szJ3ZA3ngO1tE0ALjAtFrLGzC6ldF
         zw8pyssjhn9MPX4SpF9SWR71tPHSeK5ldAQnhNFF/Gz1e4fypnKZWnIL9lcYXPXRAC6X
         GKxNhhCkSpXM00gVAMMkycZ0w2Bet9XbKrhp27zFG1Ew5bZ7eKv5S3e6txFkvDNDouf7
         QRm6V4CWDX9rjpFSOx7kCH0atjPWAq5McrEiQZjmPA8nPM/BQ5GUcY4HNorUKkDZ1gfu
         64FgAwy2Cl6LJDivar1349gRiOJ4wiR53dJmvQIOQG8sbqhhXWmv6r/T+qwQY0BLCzy0
         Je9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889377; x=1730494177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaNSsC4KUZ64ui98jp8meP1eBKQiBOs+wvC+63/8s/o=;
        b=ITdIK0UryEzWUetHwRXe7uxofiLGjtAJNEe3Tz18o++dNAE2UlBHBAGBbTdqhu+80k
         Zcl//dAIhkvt9HK14nK2ftwfImMeAivM+6peduFvJg7EHEdH4/sGMPdLv7vJcNwUpl3i
         SFqoTUYdz3M8w9czpbzN4xM65hpIP6NVA7ACS98lieIKYc5DnGTsZzdM+ui6HWGsekV7
         lle4GvVUZRtvyMP1Xaogj/0NhHYRQtOHN3XCO8NXHGV8iuZS6w1G1rnie3Z2aZoMcNsD
         H8d/v979AhrdOQZjenUnvMw6hFNXxE0OZ/b8TRnT4viNJGg4hpAMbQCSCb1TLy+T0fm9
         z6ow==
X-Forwarded-Encrypted: i=1; AJvYcCWPL9hHV5brQLwyex2Hmv3u1G4tvZ2KQ6eBXlwwlIGkC1rWzZ0AeyzowlvikuZY8rmCANd252EDmXBAh1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1ARYuESsxYXx9tvZEVsTEfe5wzLOeXEbsnHP378bFthZhNVj
	WAq4ryOXNxYleV0YUB7tBGr5pbfSz1O4odYbqT4RfklRRADltfaB
X-Google-Smtp-Source: AGHT+IFM+LN7/ckayj5f9Xw8CmTrs6jwfmfLYNRPJhoYJpT4r0Lsys1hHg6zlDyaz1K3O9N0cxcUyg==
X-Received: by 2002:a05:620a:1a1d:b0:7ab:3516:56c1 with SMTP id af79cd13be357-7b1865d36f6mr1307891085a.14.1729889376780;
        Fri, 25 Oct 2024 13:49:36 -0700 (PDT)
Received: from Tamirs-MBP.mynetworksettings.com (pool-100-37-170-231.nycmny.fios.verizon.net. [100.37.170.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323abd6csm9393431cf.94.2024.10.25.13.49.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Oct 2024 13:49:35 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Louis Peens <louis.peens@corigine.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] checkpatch: always parse orig_commit in fixes tag
Date: Fri, 25 Oct 2024 16:48:34 -0400
Message-ID: <20241025-checkpatch-fixes-commit-v1-1-1b31f9ce178b@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: quoted-printable

Do not require the presence of `$balanced_parens` to get the commit SHA;=0D
this allows a `Fixes: deadbeef` tag to get a correct suggestion rather=0D
than a suggestion containing a reference to HEAD.=0D
=0D
Ironically this:=0D
=0D
Fixes: bd17e036b495 ("checkpatch: warn for non-standard fixes tag style")=0D
Signed-off-by: Tamir Duberstein <tamird@gmail.com>=0D
---=0D
 scripts/checkpatch.pl | 37 ++++++++++++++++---------------------=0D
 1 file changed, 16 insertions(+), 21 deletions(-)=0D
=0D
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl=0D
index 4427572b24771ddb1f2bf3de3176f9437f643951..b03d526e4c454af7a4262415517=
5e109d499762f 100755=0D
--- a/scripts/checkpatch.pl=0D
+++ b/scripts/checkpatch.pl=0D
@@ -3209,36 +3209,31 @@ sub process {=0D
 =0D
 # Check Fixes: styles is correct=0D
 		if (!$in_header_lines &&=0D
-		    $line =3D~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\b/i) {=0D
-			my $orig_commit =3D "";=0D
-			my $id =3D "0123456789ab";=0D
-			my $title =3D "commit title";=0D
-			my $tag_case =3D 1;=0D
-			my $tag_space =3D 1;=0D
-			my $id_length =3D 1;=0D
-			my $id_case =3D 1;=0D
+		    $line =3D~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5,40})(?:\s*($ba=
lanced_parens))?/i) {=0D
+			my $tag =3D $1;=0D
+			my $orig_commit =3D $2;=0D
+			my $title;=0D
 			my $title_has_quotes =3D 0;=0D
 			$fixes_tag =3D 1;=0D
-=0D
-			if ($line =3D~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {=
=0D
-				my $tag =3D $1;=0D
-				$orig_commit =3D $2;=0D
-				$title =3D $3;=0D
-=0D
-				$tag_case =3D 0 if $tag eq "Fixes:";=0D
-				$tag_space =3D 0 if ($line =3D~ /^fixes:? [0-9a-f]{5,} ($balanced_pare=
ns)/i);=0D
-=0D
-				$id_length =3D 0 if ($orig_commit =3D~ /^[0-9a-f]{12}$/i);=0D
-				$id_case =3D 0 if ($orig_commit !~ /[A-F]/);=0D
-=0D
+			if (defined $3) {=0D
 				# Always strip leading/trailing parens then double quotes if existing=
=0D
-				$title =3D substr($title, 1, -1);=0D
+				$title =3D substr($3, 1, -1);=0D
 				if ($title =3D~ /^".*"$/) {=0D
 					$title =3D substr($title, 1, -1);=0D
 					$title_has_quotes =3D 1;=0D
 				}=0D
+			} else {=0D
+				$title =3D "commit title"=0D
 			}=0D
 =0D
+=0D
+			my $tag_case =3D not ($tag eq "Fixes:");=0D
+			my $tag_space =3D not ($line =3D~ /^fixes:? [0-9a-f]{5,40} ($balanced_p=
arens)/i);=0D
+=0D
+			my $id_length =3D not ($orig_commit =3D~ /^[0-9a-f]{12}$/i);=0D
+			my $id_case =3D not ($orig_commit !~ /[A-F]/);=0D
+=0D
+			my $id =3D "0123456789ab";=0D
 			my ($cid, $ctitle) =3D git_commit_info($orig_commit, $id,=0D
 							     $title);=0D
 =0D
=0D
---=0D
base-commit: 3d5ad2d4eca337e80f38df77de89614aa5aaceb9=0D
change-id: 20241019-checkpatch-fixes-commit-aa014fe6d0b3=0D
=0D
Best regards,=0D
-----BEGIN SSH SIGNATURE-----=0D
U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7h=0D
JgsMRt+XVZTrIzMVIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5=0D
AAAAQEhO1Vh/OvD8e3HTwEvNpWeLJl11NLWPF00vpbfhJuWh5YZw0c1Zet+JadYOa+a6By=0D
vg8Vjtx86wc+UjDmAJbAs=3D=0D
-----END SSH SIGNATURE-----=0D
-- =0D
Tamir Duberstein <tamird@gmail.com>=0D
=0D

