Return-Path: <linux-kernel+bounces-424821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752959DB9E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E674CB21563
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BADC1B3924;
	Thu, 28 Nov 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="N1BXHi+D"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703D25761;
	Thu, 28 Nov 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805487; cv=none; b=c77Uj2Rb+m6CB1WfgI380ZO3gU0dIrO/kfY54oCTwmffS7CttLqK36106u42XU9D4zBZeTa8iw/8Upp65ZfJb2X4Otl6GcuBap2D33ow0kYbEJVxX4E0dJl3kT7vl+BpRyjx7YFI2ctdcDGEGFpaBVo77ktesmBgb1sX9VvVZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805487; c=relaxed/simple;
	bh=MZMoSSJ1PbHEqgRQl8hIFfL0mBNTdeMxkde36dIMf8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mEIdPCPWL6b9QAmxSdjsPVMiv7Opz1lhi+CyDx1pgNSUT8DhW7hfNXNu68PdBSKa542c4t2n6gAlReJzsiagCzAo6yRfStUocv7RgQYa8MsZSGpSDcA1Phe4qKEZKZ+yq1GOTptdNh155t2FL/WwaCiTVX2rAH+It3U4UKjvnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=N1BXHi+D; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732805477; x=1733410277; i=w_armin@gmx.de;
	bh=kv7Z67wkwWyBYt8nY7JYLzssXcyPWmD/VRunzVVYLRQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N1BXHi+DU1Ppwpu36PxZJkofSkVcvNqwVXMD1UtRp3ch5CFDbszRQVVnfpFc1Wjx
	 DrFHRQk15zN2fjsQAHvYcIk6Xa/yKjAFBMckZGsh9AqZvU1NbZMlDk3lnErF26cv1
	 o7ar3q15Jqc1ICZy4ZjUysmFtQ+tNoMS7SXJ9IveKdg7SbaC+iwUIeoqib0a9RoQH
	 Hd/r+W0PRYSfM/ZpCR0SXIkYjxAGJRwJs91r8j0U6sgdfwQOM6zlQROoL45Rbm/4N
	 uq/b5ziiMQqtHGNBV0YVgBv9XsP/4WpF7ZUxdrVlLMXKyREBYgoWLEF5fBuTMqiKy
	 sTJ/YfLCa5tS2Q78OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.179.133]) by
 mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MiacH-1tw4tG002R-00nNvJ; Thu, 28 Nov 2024 15:51:17 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] platform/x86: acer-wmi: Various improvements
Date: Thu, 28 Nov 2024 15:50:59 +0100
Message-Id: <20241128145104.13538-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TrLVEgAfJUKIFTlDW08K9iqt2FVUSYPufDLiNeFyMSZMQC3927L
 tnPc6GxWwBi49o0ZRKXyCbquPeyURUrYGTRIR4FP2Ftxp4RWRszgT1DwM6/OiKI9AtYbgrw
 aWzHufpg2WenZp7pRu3G4yMJ1GwbN7wkTwIpR50w5OL71ObVW4M+9ugW6xVgE7dyfLecaYs
 Zic7DehRQupxdh3C6XHcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3L7jl6KveDk=;ko8RxmSsdqNwFYKizIwNbsy4Stz
 GkKOE+e9m7QftM4BIWFWszj2G//JzQjrTICxUZrYb6dlMTIN1B7CV6qbo+qF/AvMBLSTuCSuT
 7DA29FGNMx01as4/XKTUgWXqwl4rj+3SMNLZ+eAWPG+XMffOlwxI2mhUjQ/AtaaYlWsNHyAJP
 HTjuhb38BBiNIb3mT4S/hh8RF1hC6NNubZtQ0T1zITMHzNpKYNmoEpy8kA91UOQden9DNgLs/
 44i6U7dVAxqyLM8vIlFpqlRsolr+2Nz3lqgr7NWTfoahybecnvh3zhRb1puA0gSpyiMH7B0RS
 kS5DBP+y89OmSehM7+FHYpd/u2FYsLE+Zfhe4KBOWhYkOjzxfHHfN1dS3Bg5eQDFMijvvCzSL
 yhSO9d39AwZ/eKaO0wCIpYINTM0U0X38vEYXmJbXaKOSvaDus+nTn8BdBZCH9HL6EpS9/+0dc
 2hhfTBa0fhylnDrP5W6C5S9GdreaD7AAcOCDsx2FoYf3m03w8KifegJdnHmOHS8UNm/eP8RM3
 O9tZhXD31qS+P9iVfMenkVHvmP+w8KAG3yB2Wj2zaNF5MwiTtU/kMrB+/XMNCVe32LJYztjOC
 D/UE5zD/fqXNBGIgy5BItp5wAMM25gJOBauATU/KhwyaU0NBvLqDUKSapmddyhviOYKy2Aom4
 330/QjhcXIOJWBdI5tKszujjlyr5/T1fj60WwcZQunCJD93zGUYo1C+1mDq6htY0jOIr0vwyi
 hH+6qNlgt9KIDwquoLSHWiAQVAbEI/GEwEHJKhjJ2oqLwslksI4f912Tgkzop0v8l2tpuyGFg
 L5c3jp2m+NFCLSgRGlICOPEkRt07hNn149jYqsxJTY/PQRyq0npwzBdeH4AKTblkDFqzhWpAB
 c0OyEkWJx1N0ZBhUQ7RHzMfGJPnmJSDr/Jq1BruSBMfb5NqzG7cYNtadSxayjMZiXtJhb+6gJ
 w/xpTuSqFpiYNndAY3+CFdwjzIvLIrUlaNe5TaSUwxRYJuUVT7vzJnWgVxwcPeeOzpG0zCFEg
 uqRlxEiJHw5/jlc1c2KQUW0khvnf5mbyKmNy42tkGe0+SfIVndUjEIxMLQDxCgwk53SvzML6c
 Rk/HvT46NBMB1CxE/o0cNRFr5FLT5I

This patch series contains various improvements to the acer-wmi
driver based on user reports:

- adds support for the Acer PH14-51
- improves hwmon support
- ignores function 8 events

The changes are compile-tested only, so i would like to have them
tested on a real machine.

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


