Return-Path: <linux-kernel+bounces-302580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE6096007D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0901F1C2218E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8785A4D5;
	Tue, 27 Aug 2024 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="T+o5dM5M";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="NhmSVLi9"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747645028
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733947; cv=none; b=VPH8Zrb1iHYBAcsG3flbjYd0XnY5LblugsdjjzXp1QOjyhad3pKUReoZED1o+SnbKrhRT6m8YlmPomYwNLFJ3XdGehgDiF7+JPMRnpufX9CpbOa32RWTDTqaB2pXoqnHLUUFAK9GEuJaWj5xCRhZi/9OUNX1Nt7VZVzlzZd0fVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733947; c=relaxed/simple;
	bh=50GM5CakEvnOfWgqpegMQ7cZhbkNzNtyhKEzoFS1Gy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=L2c0LHC3wO9bU8neNY4uRBDNtC2CZ746dbSog6iD/0mqZL6uMwJU+cz2fcdKWzircP6jCK68oaKU9R+viaYpIHJ99/Iewatgi+HdkH83KxiuPxKTQP5VoG851WlLvDWOSyS0MQvvNzheH5C4bMIGsfdqxgIcbdFY+MZevxwbJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=T+o5dM5M; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=NhmSVLi9; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1724733939;
	bh=50GM5CakEvnOfWgqpegMQ7cZhbkNzNtyhKEzoFS1Gy4=;
	h=From:To:Cc:Subject:Date:From;
	b=T+o5dM5MJ8Y1rtXFB2+IkTGc/Qgc+lMDD6KuL+KjcqFNHCCl/JxG5Koa1/nGIm7XP
	 8oLERczPO2uopIxD6goI1eqybta5/rOKJW6GofRdDCTt6D4So+fe3/6cK6cERxvuJ3
	 1vxlb+sohmPWPjuGFGlUBP4FMk0HDWi2FRwGv9jDJNh2jhpOgFT+wUQyyEaYa5FLYY
	 FBXv+dqKNEPAfIBbmT0sS3sJMhR0CMy8u3VntYJYygsN/7zwt4tzI3XafzCUdzJj2Y
	 XZsQI0Kp/lY4tOT7lii0oyNTZDASVpHSmyZh94+MKtZfExprmaIbaES9dcN4G49dWG
	 bRehcghpersjw==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 03F045D7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:45:39 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=NhmSVLi9;
	dkim-atps=neutral
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 6402B5D7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:45:38 +0900 (JST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-201ec229632so45752425ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1724733937; x=1725338737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h648i1HGIlPwB0AGkcXf+01lS8pPObpRPMEGcFM2j7c=;
        b=NhmSVLi9MA/eNPigSsVgVLefGbP3GrRPsAQ9777CTIpK0w82cp4KP3PR1q2Mq6BrC6
         QECFG+gW1AgvgMfjRBqtQUwjTX69y//V2Ztcoe1w4tABJ/ryepDTrG6qzIm5sQ3ThcX6
         fTB903vQCkVfbWi4RIqLP3mfBdw6MJJgwG1gnotUfzUWGjVZ2oZrjwzbJRgQ8WJKFWv3
         y4MEOo3zivgbGd3sqmqnojZ2YYWsVa654+hiPwU+np9uqrrUb5cLvhosSS/dekeauqG0
         lTGMvQXQ6sG/YpIaTx9zXHSEQQStzmxnDS6vjkMg9pfMUlK/DSIdEX1qDnXg4LH+qR7c
         rtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724733937; x=1725338737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h648i1HGIlPwB0AGkcXf+01lS8pPObpRPMEGcFM2j7c=;
        b=MHiq7yAk3/KOwvjLlz4dt9qNTFWY8D+qSisZgL0bMXJBUIExeStGBkLnaRIyG49z49
         vu2oc9w4+71BqbUWPZD8IELEg/QtUKi14LeNZ+WCmkky6PE4qJiKGNTplRnebP1TTUTM
         TOf9DpeNU1/+wKjosnoRV+lXyjD7/cZiqP2BDjnEXIHygqYDX2UYJPGGzXsvE6VqQ8Qa
         7A3q+73/83Sz2JvRw86g/9Q3l5tgzlZT7AjLkZWNahAy/Huw70cJpX2zB+ITQs7KOkbg
         /cD0BjpBbyWiB1fskzenJRHs6B4oZ5QJvRcYMq5ufDMFnWpGxsHFsK+nSPrnhcRJ2VIK
         GttA==
X-Forwarded-Encrypted: i=1; AJvYcCV20tj0zhxPNsXWKFYbxhGuchT8XhR2NSvXunub7mbrxQPOjeSbrc+4Sqmuh5NL7VALReeO/R+1ptSI0KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZv6eDNyxGt5dYHr1JKbWWvVufwpfGmtibgou/PywSoCBTt7IM
	JDrUTROumBI6JsypHmQPR6GuJYLtHCjTZoEJFZfnPwtyoG1ALhuhK8ttp3LQOzXQ+E5YT28TqAD
	aTmBCC8/1kEB6NTuz4VlHFpJcdnUfEK7a8LlQA+5vOkDEe70VNasxqTXc6K2hW9s=
X-Received: by 2002:a17:903:1c8:b0:202:3bae:9718 with SMTP id d9443c01a7336-204df13e780mr23419455ad.15.1724733937379;
        Mon, 26 Aug 2024 21:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3bQ8pDj219nNw7r7NeAJjHbdFkX4HuI1JVNtLHr2DvXWkt2D45RP5FzKB+cmIOkfZaXHyJA==
X-Received: by 2002:a17:903:1c8:b0:202:3bae:9718 with SMTP id d9443c01a7336-204df13e780mr23419265ad.15.1724733937002;
        Mon, 26 Aug 2024 21:45:37 -0700 (PDT)
Received: from pc-0167 (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df626sm75244575ad.127.2024.08.26.21.45.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2024 21:45:36 -0700 (PDT)
Received: from martinet by pc-0167 with local (Exim 4.96)
	(envelope-from <martinet@pc-0167>)
	id 1sio59-000C5c-0U;
	Tue, 27 Aug 2024 13:45:27 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/checkpatch.pl: use \b{wb} for misspellings boundaries
Date: Tue, 27 Aug 2024 13:45:23 +0900
Message-Id: <20240827044523.46455-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Perl v5.22 (2015/6) added an expression for word boundary that can
replace our custom boundary check.

In particular, this fix detecting of typos for languages which do not
rely on spaces as much such as Japanese ("テストtest" will properly
match "\b{wb}test\b{wb}")

Note that this does not regress on commit 7da07c31b1df ("checkpatch:
fix TYPO_SPELLING check for words with apostrophe"), e.g. `doesn't` still
does not match `doesn'` (but that one just now did, as expected).
Start and end of lines also still properly match.

Link: https://perldoc.perl.org/perlrebackslash#%5Cb%7B%7D%2C-%5Cb%2C-%5CB%7B%7D%2C-%5CB
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---

Hi,

we're using checkpatch out of tree with a mix of japanese and english,
and the current regex doesn't work well for us.
I wouldn't mind keeping this as a local patch but this hopefully will
work for everyone, so might as well share.

 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..d08f884a3966 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3496,7 +3496,7 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
+			while ($rawline =~ /\b{wb}($misspellings)\b{wb}/gi) {
 				my $typo = $1;
 				my $blank = copy_spacing($rawline);
 				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);
-- 
2.39.2



