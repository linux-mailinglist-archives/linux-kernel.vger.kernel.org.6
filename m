Return-Path: <linux-kernel+bounces-576308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2066A70DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB0D189F9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD4E26A0E9;
	Tue, 25 Mar 2025 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANrLiFcg"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D726A088
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742946735; cv=none; b=euuiCNBPVvr06iGye2UBrf8rWiCZodZXVQyoViK6bSSkhLvE/Q+foc6w7v/RaZWEDy222Kj+2SC4OiCdfbVsyIwRwk40WkAsRRf8O/C/o0jFN/OPW/QNvfjAMjE9uAYhQHIGGxRDmlPfT6/F2tQktpsb+w7Nmu+uUL7n9FZmcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742946735; c=relaxed/simple;
	bh=wiUZwJkR6srdt1sGrfsnNDx3I6l74QT3/bN3FWvzFIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkN3fnfpRICnwzQ1S5w4ftRshNgLG7yIAj+8p4yU4gKrLci6luP5yVuGr4gM6WHOfwlazziyjRtrjFfEJUAm8OHTPMaW9XRdO0kf/8Jo3/TJKJ3ZnNw1R6hsngDF92rCAos33uNAVfwDQ9BgcYpg1Gky/6OBx9W1c3rX1qqBD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANrLiFcg; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d4436ba324so42365065ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742946732; x=1743551532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPMQRhtZJ2JdmVt9mU1emuouLUyy8I+L6KA1ujw0i4s=;
        b=ANrLiFcgv7lCDkIc251AKUFo5DALPSjwTKOQiU+RH1cGRiLXj84f7sCPARLBAoy1yI
         xelwe6VvyDe9EUX3HmB9miY8K4ML+CWiduNlOru3Cxfa8Img5kKOcCtQLsTq3rPBy0Oh
         mS+H0xze/ZFRFxvg3WfQ0jUcB3eSVXbCpb1G0nMKqD1WrulUyetEeGA6OwmXrZmfunBO
         rDc4anN369maJ1wvnl25KUR/aWmkr0GCEh0P+SuMZtRRQF2GQsrVkvjk75vm3eFD9S4u
         tbSBUqj3Gz7OCZovwWkVq6bBpAtHgqk1878rXQUGyhUg/p10JkRPEMDcM3zoKtjdpIAM
         v3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742946732; x=1743551532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPMQRhtZJ2JdmVt9mU1emuouLUyy8I+L6KA1ujw0i4s=;
        b=Jl9FdwqB9VXQFOW6k4m1wL+9PWlB/GjXcdk4/NxLRWd/5szNf+TkYADqCjwogDtKR0
         xL7Q2gc6WQQFacsWU2VOl5rx9O0ZlK74lE+qQmhqYFs0l31bPe1Hzk/olwU+GI6V6SYa
         jAMom53LDwnF6b0WIG/8itq9Ui/mqFx1eXrk8xhSm4lCqP77d/CBetyf9NptoNZatLZV
         NLPpO6MXvtMe845DZzq0e3eFNrm14l9NMTIKhYB82QkLPXDoKF39MaaVy3/oFbqtAHph
         G6UvN0Nkcf+kyAifHE5LZGpC5vT1C55ZUm3eEVpSoZN6O3EgirFDVKKelTytEM0ekX4P
         3hAw==
X-Gm-Message-State: AOJu0YwKXFjKCykmpTfctFeYYxv2TGot/EXYMS5KqCKDGIQilrG3Std2
	EyzSSI8WeVk/4VFuIA0WqoqKl5oXhJyMamToKO1USRM2VAq+bdK4Hpytg6UG
X-Gm-Gg: ASbGncvNOMvm60jFWpgYHpLArg1r8iTU3s2HvwHP1t23wIrNqTQ62FY9s5MBFUJzG3K
	yigr1V8a441tERNPoZo6e7ocIwCt0UAXv1CpBRpzklU+GQXX9GWxHGVVZ24vD48BrvjurZYK37o
	l3B2ifNz8bnVyV1eUWdpe5ZUxManEkq8Yz3L36xzNidHddFj7aBiRS7Prjdv8w7TTzqDVXreO1e
	1sPdLgHDL8NU0+OGGk4Sqkn4cL0wwfZmmN1h+3qVgH8NqVviXV5sxV+dMvW0Wa6iT19m3F7KdUP
	l/rO8YqtqizlrIaxSBYcbS4ZrDsyTnBWy4RsxG3vUkU4F6v+GIwrmZTLRjpZfQHTAqq2zmE+JsA
	xVlQPyyz0twwW
X-Google-Smtp-Source: AGHT+IEJEycHn9UgKV49bovfsgQFld91VpXVRaBjHj6pddzjdQoXj5n3sqHfLyOI986iIJZyKrBhCA==
X-Received: by 2002:a05:6e02:349c:b0:3d3:dd60:bc37 with SMTP id e9e14a558f8ab-3d5961c530dmr216239575ab.22.1742946732291;
        Tue, 25 Mar 2025 16:52:12 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3d5960cea10sm25191175ab.45.2025.03.25.16.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:52:11 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/3] checkpatch: qualify do-while-0 advice
Date: Tue, 25 Mar 2025 17:51:55 -0600
Message-ID: <20250325235156.663269-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325235156.663269-1-jim.cromie@gmail.com>
References: <20250325235156.663269-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a paragraph of advice qualifying the general do-while-0 advice,
noting 3 possible misguidings.  reduce one ERROR to WARN, for the case
I actually encountered.

And add 'static_assert' to named exceptions, along with some
additional comments about named exceptions vs (detection of)
declarative construction primitives (union, struct, [], etc).

cc: Andy Whitcroft <apw@canonical.com>
cc: Joe Perches <joe@perches.com>
cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0c4f578ea6e7..044157ba5b47 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -150,6 +150,24 @@ EOM
 	exit($exitcode);
 }
 
+my $DO_WHILE_0_ADVICE = q{
+   do {} while (0) advice is over-stated in a few situations:
+
+   The more obvious case is macros, like MODULE_PARM_DESC, invoked at
+   file-scope, where C disallows code (it must be in functions).  See
+   $exceptions if you have one to add by name.
+
+   More troublesome is declarative macros used at top of new scope,
+   like DECLARE_PER_CPU.  These might just compile with a do-while-0
+   wrapper, but would be incorrect.  Most of these are handled by
+   detecting struct,union,etc declaration primitives in $exceptions.
+
+   Theres also macros called inside an if (block), which "return" an
+   expression.  These cannot do-while, and need a ({}) wrapper.
+
+   Enjoy this qualification while we work to improve our heuristics.
+};
+
 sub uniq {
 	my %seen;
 	return grep { !$seen{$_}++ } @_;
@@ -5896,9 +5914,9 @@ sub process {
 			}
 		}
 
-# multi-statement macros should be enclosed in a do while loop, grab the
-# first statement and ensure its the whole macro if its not enclosed
-# in a known good container
+# Usually multi-statement macros should be enclosed in a do {} while
+# (0) loop.  Grab the first statement and ensure its the whole macro
+# if its not enclosed in a known good container
 		if ($realfile !~ m@/vmlinux.lds.h$@ &&
 		    $line =~ /^.\s*\#\s*define\s*$Ident(\()?/) {
 			my $ln = $linenr;
@@ -5951,10 +5969,13 @@ sub process {
 
 			my $exceptions = qr{
 				$Declare|
+				# named exceptions
 				module_param_named|
 				MODULE_PARM_DESC|
 				DECLARE_PER_CPU|
 				DEFINE_PER_CPU|
+				static_assert|
+				# declaration primitives
 				__typeof__\(|
 				union|
 				struct|
@@ -5989,11 +6010,11 @@ sub process {
 					ERROR("MULTISTATEMENT_MACRO_USE_DO_WHILE",
 					      "Macros starting with if should be enclosed by a do - while loop to avoid possible if/else logic defects\n" . "$herectx");
 				} elsif ($dstat =~ /;/) {
-					ERROR("MULTISTATEMENT_MACRO_USE_DO_WHILE",
-					      "Macros with multiple statements should be enclosed in a do - while loop\n" . "$herectx");
+					WARN("MULTISTATEMENT_MACRO_USE_DO_WHILE",
+					      "Non-declarative macros with multiple statements should be enclosed in a do - while loop\n" . "$herectx\nBUT SEE:\n$DO_WHILE_0_ADVICE");
 				} else {
 					ERROR("COMPLEX_MACRO",
-					      "Macros with complex values should be enclosed in parentheses\n" . "$herectx");
+					      "Macros with complex values should be enclosed in parentheses\n" . "$herectx\nBUT SEE:\n$DO_WHILE_0_ADVICE");
 				}
 
 			}
-- 
2.49.0


