Return-Path: <linux-kernel+bounces-438610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E1E9EA37F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EFF16541A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5035A2594;
	Tue, 10 Dec 2024 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="t8Xq2ZX+"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02D625;
	Tue, 10 Dec 2024 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789832; cv=none; b=Ivhk+ZyaI5myPBdIgznkS7pQR1FL8jV0XEo+xIYXF7MINa8jsLvuOwdKUg7rgen9QX5jY2xALns0hV4XOmAWbfJAquQUk/UMiGIONT2IwFlVVLBIewTgKESp4te0JMiyTFiq5gegMbIpu6LmSFRUrdF1ZmtIHh8O88QeQkSj91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789832; c=relaxed/simple;
	bh=eHgcCl7eeEdu+XL+uN2hweyERyarVn03egqtMM0Jdm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G7PFtPzfBKEpPvnRysdWbr/kTDHpOv6+FJP4x03oj2r/p6GTx8bjNHyu9ucGouNcQoM/0dMSJL9EnKOURDBKRokzn23qRt22X6PzJTy4gXyPO/9c6oz54H9ccUPONVWK6w4g0HnMKRwoh0iLkalOgePGFo1IC87klq9MXtSbsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=t8Xq2ZX+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733789822; x=1734394622; i=w_armin@gmx.de;
	bh=+N+6LRU3hDW91+6LwcfNs+BEXthoScB8y2N0r4S/0hs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t8Xq2ZX+/3EtekNv8VisN95xKYb3O+Q+kUs0gskuwJX5GREu9LhCZxA8Xpfd6+G/
	 1+eQXxBXh+m99cFBh8h/hKHzlZf+exkPwG8F66lGrC4x6ECgdFeLqNPLR5vUSglb5
	 352qdqEXr1i7qI+kvcDqEfj3DwtTvQTee0n0ia6vDNgxfjKmvu0di1pKjCaicUJbE
	 i2QRd2XQ4aPJyQ8QKF3dzj9LITZbqTpE0hN2Cgzsx2XvFkcuXaHTYc5Tb/ZYQX2sL
	 Wctsy3rELULCTvZQi2qZ5tXtTwmRlqR4Xl6wJkVuY1WN+narJVwJ+oTL9SN3i0c1D
	 5Cb6VqQmSlUX6qduNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.14.230.110]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1ML9uU-1t2j5L3Dbm-00UAFA; Tue, 10 Dec 2024 01:17:01 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuurtb@gmail.com
Subject: [PATCH v4 0/5] acer-wmi: Various improvements
Date: Tue, 10 Dec 2024 01:16:52 +0100
Message-Id: <20241210001657.3362-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SRhVlTPI+g05HNkBBq+9Y+Pj/WVlAZex351l6uxuOhm5yjSUECy
 pzMtAOSkP+cdPo3om9UNaxX7XUS6eKqwBDHy/S3CIt+166AHaxXQrEU7OE208niI8vf87y3
 FUWOJAQ8e1v7fyDoCAcUVsibPHvQmihm5dqV3MInZp8MkDmEhmpSIgJDJhIKZF1OIii46Gn
 xL0GMWTGR3lkTv1mgQF3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3lXxiB6t0yY=;mdHmBmtQxZOIcK4lArvg3svGzET
 UzoVBS3RNdMy/GnFvDja0VD4DGjJ8uEOGJvOnHVDuERHXh57TRq4TL0QmxQwj+bd8Aum7YmWV
 +hhmgPG1Q9sOSBAf9IJJBEQ6sCVs8xwjMH3H/608gl/0m97wFmtJC9fkGZs2EGfyrXXhVXeBb
 2MTaSCWkqyuKeDEx8JOBbS1sKCeCOUX2cy9Jig2Otl+iIpWQGxzHJGdlBtoHgI7Srjx5DuO6o
 HH65vG6TdNFtdLAQV/Oo8EFRVyl1VFfBe+KoApF04KbhKComGQhG67FmOGh8/0lE0qQ6p72dU
 mrNmBfxSi5kceK0eECPdAD/PZOHjeN8RxryZPRHvbbcpjkrbE8exLs6Jx+b4SptYlf2q2wxYO
 LZk/t4z/zzGIJ8str6ujx99sziVJlB1xnANoXQrz4QrRb6KX+0a1oQ+aOK2th1wVQn3VbVq48
 geBfJWtqEh6+gvGGgqgn6z+tAF4hXuzIXFK9vontPxqZMQnx35fYJ5V03MSYqzDiDYvO1+1Sn
 j0Ek9HXkTumf9BSfccCO1jFgi485w+mxKUJuxZYKK4XyqfX1nVPufAOpSbd7UVqPO2bO5IvOw
 4W8nJp10poBAEblAynpzf/RmRinw/eGRPmGTtaGXOYhQlIKPxA6etIcZXF8CXOF1dV7BnUaLF
 rDMkZHU8asI6/GDRTcbr9V5ahNjnJLY3szYhfWRm2kKnlOxVQ+fsPuNH8u6GK3EZI6/yqMj7H
 lQ60Izea4omVG1lVKWp3DirWqKEevKqNuuvQlbYRECsgAAMpNkkrMIv+Kt7h9YhXc7+yVsbhP
 HU6IsFmKlK/dD/6YFElHxURuTcno343lOOV66ORY0wI18PtfKW5sEyGQN3iafGGDlNU/tirJK
 oY6PtJeKgUmSkw0r+RUyNeHHiGygxQ95B9imghInuNW6erp2vA8BPfqMAyBoQNAmOCU3Ip3bd
 zdx/dHxtd4DDK8eLHbAun089TqVsX84LgEQLbJ+b3OzT7McqOXjl12Ed3dXGreZ1DtYHJ4niD
 MzPulQiNxkllqxt2X53ZnZs5eiL4ilm1WTjvqgm/62taOqrIszr3m7Ly9O5izfZg1/lOCxJQ8
 jZ3JnuJS5pAFrCVp+CK9eZwZihE1mF

This patch series contains various improvements to the acer-wmi
driver based on user reports:

- adds support for the Acer PH14-51
- improves hwmon support
- ignores function 8 events

The changes where tested on a real machine and appear to work.

Changes since v3:
- fix duplicate definition of ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK
- add Tested-by tags

Changes since v2:
- fix compilation error after patch 3
- replace GENMASK() with GENMASK_ULL() and adjust bit numbers

Changes since v1:
- fix spelling issue in patch 2
- rework patch 3 and 4
- add Reviewed-by tag to patch 5

Armin Wolf (5):
  platform/x86: acer-wmi: Add support for Acer PH14-51
  platform/x86: acer-wmi: Rename ACER_CAP_FAN_SPEED_READ
  platform/x86: acer-wmi: Improve error handling when reading gaming
    system information
  platform/x86: acer-wmi: Implement proper hwmon support
  platform/x86: acer-wmi: Ignore AC events

 drivers/platform/x86/acer-wmi.c | 166 ++++++++++++++++++++++++--------
 1 file changed, 124 insertions(+), 42 deletions(-)

=2D-
2.39.5


