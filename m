Return-Path: <linux-kernel+bounces-251778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9F9309AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B50281B50
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 11:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CAD4D9F6;
	Sun, 14 Jul 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="JZi8vq7I"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15691BC4B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720955654; cv=none; b=ahTyRShzSbHuiMlXBqkEarEQGQLR1jVXmU5tdV0H8VHZi+haz+0MjlWjDukbQsh6VVKEy5bno5bqpod9isI/avSXcMqgk9tIv7e95D3LS5UqowF0TDyzQ/79M5Pm6wYRQ0/tdqsgPYY/QgmxiJbPgFSBGZpM5ljhN4xEyG4mTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720955654; c=relaxed/simple;
	bh=h1xTJ4fP96gHcQuYDPlEsz6mBKT5bjA5Y9eo+Jm4T3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyGd5owZGbQMNtxgpsdV38NHOTlO42PO2dU/hKi5zdVzgd2a1a+KM5ZePjpHRvI9NAO5hRFoNwEocL2N6mwVa5h3XnjXMBNkD9y9/1zHo933LISsMWesnvucc1T1b/QaXldFY0F6Galg3c3tIQKq3pclcREpw3S3s6yTC231S+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=JZi8vq7I; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720955638; x=1721560438; i=spasswolf@web.de;
	bh=l4EpXJ8Ja75qWrpYo/fqG+/qJ0Ot5rBUZq+WMCVYMRE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JZi8vq7I1lCujThCcGXYdfr4N2wM2x5YhSV1lryfv5ORy/Dl3MvfPzVIAoih9w6n
	 TKarMzs2GX5L6/LwNqfNwyBQQtpr5dHVcZ2Q0qw15Lc7Mbvv7RGa9wOpBBkvbz8pS
	 qj32fc89OjoZNgf9U9BTD80OIIcOZAu3PpnZEXwy6N6w/gWS3VUOtXj/bg+NTIY7q
	 ieAfhjpjng6kK9rmzxPnyDTHPXJai4OByxqB0dS2nFXy00vcLaejah9Q6tA0SdO5g
	 xY8M0Cq6dL7sJbyU7NrBcb30tnFLnPEIyxVII7yLeqr5R5irZzLsmX+9b46kRu+T6
	 ShPhLH5tH98JK96zQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MiuOk-1rqIy22Nka-00acP1; Sun, 14 Jul 2024 13:13:58 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v2] kbuild: deb-pkg: fix building with bindeb-pkg
Date: Sun, 14 Jul 2024 13:13:55 +0200
Message-ID: <20240714111356.12234-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 878qy48cxq.fsf@linux-m68k.org
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RZBMQMJny+2gDiCb7GZYU6rJnbxJCfP70Xn7hzF+azKC1+qMQ8j
 SxxdyqT2SZmBTwOFzp7/R7zGsgM0yNsdMEQasuixRzJzCrOemeoUb8X68R6zzSmAcYsvHgX
 tgPbXdZP5LavCt7u35DQWgEH+UQ6urJcJYUxUzH3WBDzga7j0sNK+BLWRmLSz+SACEdaioi
 9RoQ9wxvbNx7YHQUj+fRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h+qSw5rfUw0=;BlZlHqLgVeiXpdCFEDQdmrhIcCp
 ACXykdWqJ0c3HxNiep6yWW8E8v++T5f2jCDAct1mJ2Nxel0xNL7oEPEUhW2MF/QqEEfzyaYf8
 pLvGt439cXEZgF/s9ea6ilufWRuHVdN72dsJErAwXYfU54Rc8ToGBJhtD0VH2sIpQTnij5o74
 b01tPwNN3TFkyovYlspJJx+kB1JZCjumV1jIY055hKEpg+0LRaqnS9wGbsWHJuJu2o6Vis4/h
 cliXyUDFZEfSp6GN8068AnSJiw9KLP4gHWATBqT2HoNJFvkIVrd/5tOoNWSQIYbPOrLOLv6p9
 gAcUWyvzFWGja/Ub+uMNNUwn1fzKKXKCOx5jfH4q/efO7h443fluRpkEtw5y/b7sORUigJ2Al
 uMzzRJGmWtg+fzkuj3Qz4+OxERs32C0hVjhuyF2R5YEdZzrRzAwkEncxq3KjzIniwvOfSZyLf
 s9uNIkzfKeUu/zrg+C4f1wB/nM6/PyjYlc0NnavO3wcy8X6t6uW1CJhuoX1//AaIiOcDU/9z8
 kh3cFbJlgV1r4mbaVtrERLxB0g9MDd8CXkG5BBeRIKSeKqJjkPQNp37resy+NpNU0VTExD6Ch
 FjvOrEjfieGZyJZ5lu4ZMY+6I6srClxfb5ldj86+iRRsafLIFpCDA2HEAfBZJwwHW9rKI+mCd
 iSwl09qosRkVEWUjiKhOzSkjS1kxM14OtQNh26NkIGQL3PoCWMGuyF80vVVtZmwxmCl6kkMgO
 +/1MTsVOKPu/XYoZZXH8pt6LhCkaSW0tfvJJHBNdiHfe4JGboUvOuwCsUKNZYqFt91P6u5T9W
 haDaQkYHMg+/hopk8cM2FW/g==

Since the introduction of "set -u" into scripts/package/mkdebian running
the mkdebian scripts fails when it is called with no arguments (which is
the case when building the kernel with 'make bindeb-pkg'). This patch
introduces an additional check so mkdebian can be run without arguments.

Fixes: 8ef052389f7f ("kbuild: package: add -e and -u options to some shell=
 scripts")

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 scripts/package/mkdebian | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 196b14e8ad47..fbd01175c870 100755
=2D-- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -135,7 +135,7 @@ else
 fi
 maintainer=3D"${name} <${email}>"

-if [ "$1" =3D --need-source ]; then
+if [ $# -eq 1 ] && [ "$1" =3D --need-source ]; then
 	gen_source
 fi

=2D-
2.45.2

Sorry, but the previous patch contained an embarrassing error, here's
the fixed one.

Bert Karwatzki


