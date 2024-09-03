Return-Path: <linux-kernel+bounces-312457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6409696E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8741F22B16
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B44205E13;
	Tue,  3 Sep 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="sB+HiUOy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714E1D67AC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351619; cv=none; b=J2ojNHB3caoqHYNy5ekWQvIzc665UuBu1owCe3bNj9YMaBAxu32CbRpXBv229PKeYy49xZpMyH7+9gYIh98eGKvg7U1M9jk2fuOdid3ci5DV+8FGyFfKjuT579DsmmFUk+9XZOzfrcsJlOjxnrK4Hl3IkCcMllMf4aDf/RmpMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351619; c=relaxed/simple;
	bh=zQ7ucgyJvJz5JjcFYbNwCsbg4nagkKxZ+nZ3sV8msGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8ZCsqtJEEqQo9nzMSH3WBGubZpWdHNfFFYLcADd2GJYaoApI5V/UXY7IB5PSeTv1EzLo6nDqRWQP821SlINkqFDOGHOkjaqj3Jbqi7J+rYQwIKOlGXbzH12ljBI7SccJPhQOGKRMJGfeMUGZswOhkbbz024UC2WilrTSfzFvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=sB+HiUOy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bafd879aeso6923145e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1725351614; x=1725956414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EgKUHrUOMpyjZi6C5EjxXwCmD9bSiBGL0khiLuKOJRk=;
        b=sB+HiUOyKHJXiq/sWK5pJVtBJWtZtPkULfy9u/NqGUUuhyqg65tF6DEXbm3R3kXf1b
         a0LhGQ+EyBzQk5YtWmi0sPa1hei1mVXPmkjUNUuWn1nIePJc2sIi2AtuNWlwCJWWM9C3
         DHjY8zvV8CVm1RQCOUGdnrIDE4Y2TnYlFRmPhWHnK4TRx0uds357rZLBMK27eZvGzEY4
         pxVrMBM+Zn/h/viADzqOGGOWDDrmxGuXBMaG3PxNUbjd7/xEHya5rVq5BHCheLx8cJKK
         XjODprF47UlcxltJA/CFXse0uO2fYzx5tMjGA2VFwcRo1YoVjSpNllDJdO9pLvFkn4V/
         SN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351614; x=1725956414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgKUHrUOMpyjZi6C5EjxXwCmD9bSiBGL0khiLuKOJRk=;
        b=M3aBYuA4mRL2zJn9gsVP5yY4t3Ps2K2pY/ICytFC5PDHihRDySTfIPQ4C7v6Q77OCR
         oQ0xac0Ryd6o12Ar9reB2ZQDLC+c91ECRJDreCuFVdCrqno7WKJGILAu5mfzC7TWYpiD
         JJ+0Uc6XzWstiP9xxSF14mKKmW79sAWy4Te7LJQe06ATdhC2hiif6UxUtO+HV10PAH3Z
         Khp2rhI3CbPAypVdCA1NiE0t22pqXXmhCyZNCVeYj3jo3zWlzrcjxxTWN1vvNaLzmHrc
         3oOBIhqQSZEXzfEGG7cXc8Uk5CpdazJ9BSfcp76u3mQe0YGrDrAV26ph+/gcdRlF40oT
         FvPg==
X-Forwarded-Encrypted: i=1; AJvYcCXeHKsa7be6Fk0rc1i2eqINj2qv5mcDfZlJTcI/H7H9FRrXo/sZdaA/jXU0Mndw3/1/pV11wrPyJrDVzls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY541TnzRnZGzM+RFrmzPjLEbIOYUduJyya8XBFFQtR2+MphS
	iobzoPgWfreffFK8FI9P+Ti/pLRg0UoR+9eVj+CsWJL/3HUwxXjLn/R66ny5Jlpj3wY5WS+yPi/
	n+eHP5WEFUoaezkQuhWDPAKLlRVUX8C1MPCaQoUzy3kxeJa0lFZ3qWVw=
X-Google-Smtp-Source: AGHT+IEFFqFL6Z+i6DHqcKyxe8/RJtfANtTvmRv05p6nE4LwpVsuRRRoI4GM1xfpkOExobdfMfIk6g==
X-Received: by 2002:a05:600c:4f4a:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-42bbb10d9eemr52777185e9.1.1725351614019;
        Tue, 03 Sep 2024 01:20:14 -0700 (PDT)
Received: from localhost (dslb-002-205-017-144.002.205.pools.vodafone-ip.de. [2.205.17.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba641db07sm195757675e9.34.2024.09.03.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:20:13 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@mellanox.com>,
	Petr Machata <petrm@mellanox.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net V2] net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN
Date: Tue,  3 Sep 2024 10:19:57 +0200
Message-ID: <20240903081958.29951-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

When userspace wants to take over a fdb entry by setting it as
EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().

If the bridge updates the entry later because its port changed, we clear
the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
flag set.

If userspace then wants to take over the entry again,
br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
update.

Fix this by always allowing to set BR_FDB_ADDED_BY_EXT_LEARN regardless
if this was a user fdb entry or not.

Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user=
 as such")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
Changelog:
V2:
 * always allow setting EXT_LEARN regardless if user entry
 * reworded the commit message a bit to match the new behavior
 * dropped the redundant code excerpt from the commit message as it's
   already in the context

 net/bridge/br_fdb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index c77591e63841..ad7a42b505ef 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br=
, struct net_bridge_port *p,
 			modified =3D true;
 		}
=20
-		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
+		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used =3D jiffies;
-		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
-			/* Take over SW learned entry */
-			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+		} else {
 			modified =3D true;
 		}
=20
--=20
2.46.0


--=20
BISDN GmbH
K=F6rnerstra=DFe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=F6psel


Commercial register:=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=A0DE283257294


