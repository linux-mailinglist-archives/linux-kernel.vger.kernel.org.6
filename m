Return-Path: <linux-kernel+bounces-362538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1985399B613
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4496D1C21249
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9E8770E5;
	Sat, 12 Oct 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vMZIYedK"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA16EB5C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728749883; cv=none; b=B+W5XbofSJKgPzjBo60nzK9rD6+v05zzeRuPAp3a5YBuVzMT0Tkvi/P7KMoa9GiCMX/iQAdWbwY1Za9yX8lTmsi0bFAsoopRcN32UOIJeNT2Jg3k07eE6UAsh/xsnqRN7G5UP1r3Gaeu64OmDme07zm8qgBQVtiiSqM7LbF3MX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728749883; c=relaxed/simple;
	bh=J73VI66jlEHQkdw/SEk5v894zqFxKYyw9Pi4Yk1ohkw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhBCoSBtJopFItRVbAz72iA6c4aVeZGOA7pT3rtmSJUhv21k8fK6c36aARzfyYER7OG5Gi8WO/kHL+Srlh/fMKtxwrS8Y8ua5vZXCfdvDA3cdU2RvzGcr9oC2TZ2DoefDenO1C4roe0aNZjBbmN3dqkng/O3d4UdYa2Wm182lS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=vMZIYedK; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1728749879; x=1729009079;
	bh=77Ape9Xb6Q3g6e6nDVCqziVhef5VruLIYSH0AB8UTZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vMZIYedKwY/dEtxPapHup3sqgF0kgHa0GWH4ICz3BkNHUAMF9NDSYCUIbocKvkcqv
	 +KTqFzsZV+l3BA8WISR4rCJi/QXRCFM1BrLkw6dyIkbstftqMCjsUsu3HJ/z4eQBDJ
	 CGYlP10DwsLeziQ3SS1Hca0bfyc1PxYU6Q/PmPIU/Nz1leLduDyghVWVkPBHlLbgj6
	 KAynY5qVoRvw1222ZF2NNGNtjbhUcvMiZJED9FljKko7oKPgwL00AhuibivvqnnwvO
	 T8ZnB07mdAOkoSM2x8TubawPtqjuVZe1XFFBNGf1JkNoQ1dSoM+ccNEFbu02heagzI
	 4/OjSqPk6iO+Q==
Date: Sat, 12 Oct 2024 16:17:55 +0000
To: florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org, ayushtiw0110@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 3/3] staging: rtl8712: Introduce auth_algorithm macros
Message-ID: <20241012161638.67030-4-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20241012161638.67030-1-dominik.karol.piatkowski@protonmail.com>
References: <20241012161638.67030-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 2d14e7b65101fff78c6faa3d16032d7ffd93ee08
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Currently, auth_algorithm is assigned/compared to using hardcoded
numbers. Some of the lines are commented, some of them are not.

This patch introduces macros that replace numeric assignments and
comparisons of auth_algorithm, increasing readability.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8712/mlme_linux.c          |  5 ++--
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 25 ++++++++++---------
 drivers/staging/rtl8712/rtl871x_ioctl_set.c   |  3 ++-
 drivers/staging/rtl8712/rtl871x_mlme.c        |  7 +++---
 drivers/staging/rtl8712/rtl871x_security.h    |  5 ++++
 5 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712=
/mlme_linux.c
index fa6b0adec746..fcd2e0a9487a 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -19,6 +19,7 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 #include "mlme_osdep.h"
+#include "rtl871x_security.h"
=20
 static void sitesurvey_ctrl_handler(struct timer_list *t)
 {
@@ -92,7 +93,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapte=
r)
=20
 =09r8712_indicate_wx_disassoc_event(adapter);
 =09netif_carrier_off(adapter->pnetdev);
-=09if (adapter->securitypriv.auth_algorithm =3D=3D 2) { /*/802.1x*/
+=09if (adapter->securitypriv.auth_algorithm =3D=3D _AUTH_8021x_) {
 =09=09/* We have to backup the PMK information for WiFi PMK Caching
 =09=09 * test item. Backup the btkip_countermeasure information.
 =09=09 * When the countermeasure is trigger, the driver have to
@@ -121,7 +122,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adap=
ter)
 =09} else { /*reset values in securitypriv*/
 =09=09struct security_priv *sec_priv =3D &adapter->securitypriv;
=20
-=09=09sec_priv->auth_algorithm =3D 0; /*open system*/
+=09=09sec_priv->auth_algorithm =3D _AUTH_OPEN_SYSTEM_;
 =09=09sec_priv->privacy_algorithm =3D _NO_PRIVACY_;
 =09=09sec_priv->PrivacyKeyIndex =3D 0;
 =09=09sec_priv->XGrpPrivacy =3D _NO_PRIVACY_;
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/stagin=
g/rtl8712/rtl871x_ioctl_linux.c
index f832501cc196..832c6c64aa68 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -26,6 +26,7 @@
 #include "rtl871x_ioctl.h"
 #include "rtl871x_ioctl_set.h"
 #include "rtl871x_mp_ioctl.h"
+#include "rtl871x_security.h"
 #include "mlme_osdep.h"
 #include <linux/wireless.h>
 #include <linux/module.h>
@@ -325,18 +326,18 @@ static int wpa_set_auth_algs(struct net_device *dev, =
u32 value)
 =09=09=09=09=09=09 Ndis802_11Encryption1Enabled;
 =09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09=09=09 Ndis802_11AuthModeAutoSwitch;
-=09=09padapter->securitypriv.auth_algorithm =3D 3;
+=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_AUTHSWITCH_;
 =09} else if (value & AUTH_ALG_SHARED_KEY) {
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09=09=09 Ndis802_11Encryption1Enabled;
 =09=09padapter->securitypriv.ndisauthtype =3D Ndis802_11AuthModeShared;
-=09=09padapter->securitypriv.auth_algorithm =3D 1;
+=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_SHARED_SYSTEM_;
 =09} else if (value & AUTH_ALG_OPEN_SYSTEM) {
 =09=09if (padapter->securitypriv.ndisauthtype <
 =09=09=09=09=09=09 Ndis802_11AuthModeWPAPSK) {
 =09=09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09=09=09 Ndis802_11AuthModeOpen;
-=09=09=09padapter->securitypriv.auth_algorithm =3D 0;
+=09=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_OPEN_SYSTEM_;
 =09=09}
 =09} else {
 =09=09ret =3D -EINVAL;
@@ -414,7 +415,7 @@ static int wpa_set_encryption(struct net_device *dev, s=
truct ieee_param *param,
 =09=09}
 =09=09goto exit;
 =09}
-=09if (padapter->securitypriv.auth_algorithm =3D=3D 2) { /* 802_1x */
+=09if (padapter->securitypriv.auth_algorithm =3D=3D _AUTH_8021x_) {
 =09=09struct sta_info *psta, *pbcmc_sta;
 =09=09struct sta_priv *pstapriv =3D &padapter->stapriv;
 =09=09struct security_priv *spriv =3D &padapter->securitypriv;
@@ -472,13 +473,13 @@ static int r871x_set_wpa_ie(struct _adapter *padapter=
, char *pie,
 =09=09}
 =09=09if (r8712_parse_wpa_ie(buf, ielen, &group_cipher,
 =09=09=09=09       &pairwise_cipher) =3D=3D 0) {
-=09=09=09padapter->securitypriv.auth_algorithm =3D 2;
+=09=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_8021x_;
 =09=09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09  Ndis802_11AuthModeWPAPSK;
 =09=09}
 =09=09if (r8712_parse_wpa2_ie(buf, ielen, &group_cipher,
 =09=09=09=09=09&pairwise_cipher) =3D=3D 0) {
-=09=09=09padapter->securitypriv.auth_algorithm =3D 2;
+=09=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_8021x_;
 =09=09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09  Ndis802_11AuthModeWPA2PSK;
 =09=09}
@@ -1450,7 +1451,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09=09=09 Ndis802_11EncryptionDisabled;
 =09=09padapter->securitypriv.privacy_algorithm =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _NO_PRIVACY_;
-=09=09padapter->securitypriv.auth_algorithm =3D 0; /* open system */
+=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_OPEN_SYSTEM_;
 =09=09authmode =3D Ndis802_11AuthModeOpen;
 =09=09padapter->securitypriv.ndisauthtype =3D authmode;
 =09=09return 0;
@@ -1469,7 +1470,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09netdev_info(dev, "r8712u: %s: IW_ENCODE_OPEN\n", __func__);
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11Encryption1Enabled;
-=09=09padapter->securitypriv.auth_algorithm =3D 0; /* open system */
+=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_OPEN_SYSTEM_;
 =09=09padapter->securitypriv.privacy_algorithm =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _NO_PRIVACY_;
 =09=09authmode =3D Ndis802_11AuthModeOpen;
@@ -1479,7 +1480,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09=09=09"r8712u: %s: IW_ENCODE_RESTRICTED\n", __func__);
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11Encryption1Enabled;
-=09=09padapter->securitypriv.auth_algorithm =3D 1; /* shared system */
+=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_SHARED_SYSTEM_;
 =09=09padapter->securitypriv.privacy_algorithm =3D _WEP40_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _WEP40_;
 =09=09authmode =3D Ndis802_11AuthModeShared;
@@ -1487,7 +1488,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09} else {
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11Encryption1Enabled;
-=09=09padapter->securitypriv.auth_algorithm =3D 0; /* open system */
+=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_OPEN_SYSTEM_;
 =09=09padapter->securitypriv.privacy_algorithm =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _NO_PRIVACY_;
 =09=09authmode =3D Ndis802_11AuthModeOpen;
@@ -1672,7 +1673,7 @@ static int r871x_wx_set_auth(struct net_device *dev,
 =09=09=09=09  _NO_PRIVACY_;
 =09=09=09padapter->securitypriv.XGrpPrivacy =3D
 =09=09=09=09  _NO_PRIVACY_;
-=09=09=09padapter->securitypriv.auth_algorithm =3D 0;
+=09=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_OPEN_SYSTEM_;
 =09=09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09  Ndis802_11AuthModeOpen;
 =09=09}
@@ -2017,7 +2018,7 @@ static int wpa_set_param(struct net_device *dev, u8 n=
ame, u32 value)
=20
 =09switch (name) {
 =09case IEEE_PARAM_WPA_ENABLED:
-=09=09padapter->securitypriv.auth_algorithm =3D 2; /* 802.1x */
+=09=09padapter->securitypriv.auth_algorithm =3D _AUTH_8021x_;
 =09=09switch ((value) & 0xff) {
 =09=09case 1: /* WPA */
 =09=09=09padapter->securitypriv.ndisauthtype =3D
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/staging/=
rtl8712/rtl871x_ioctl_set.c
index 569d26425250..9ddfe7a1d715 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
@@ -19,6 +19,7 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 #include "rtl871x_ioctl_set.h"
+#include "rtl871x_security.h"
 #include "usb_osintf.h"
 #include "usb_ops.h"
=20
@@ -318,7 +319,7 @@ u8 r8712_set_802_11_authentication_mode(struct _adapter=
 *padapter,
=20
 =09psecuritypriv->ndisauthtype =3D authmode;
 =09if (psecuritypriv->ndisauthtype > 3)
-=09=09psecuritypriv->auth_algorithm =3D 2; /* 802.1x */
+=09=09psecuritypriv->auth_algorithm =3D _AUTH_8021x_;
 =09if (r8712_set_auth(padapter, psecuritypriv))
 =09=09ret =3D false;
 =09else
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl87=
12/rtl871x_mlme.c
index 66f9fc51c147..1ca94e90dfe6 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -23,6 +23,7 @@
 #include "recv_osdep.h"
 #include "xmit_osdep.h"
 #include "mlme_osdep.h"
+#include "rtl871x_security.h"
 #include "sta_info.h"
 #include "wifi.h"
 #include "wlan_bssdef.h"
@@ -768,7 +769,7 @@ void r8712_joinbss_event_callback(struct _adapter *adap=
ter, u8 *pbuf)
 =09=09=09=09=09ptarget_sta->aid =3D pnetwork->join_res;
 =09=09=09=09=09ptarget_sta->qos_option =3D 1;
 =09=09=09=09=09ptarget_sta->mac_id =3D 5;
-=09=09=09=09=09if (adapter->securitypriv.auth_algorithm =3D=3D 2) {
+=09=09=09=09=09if (adapter->securitypriv.auth_algorithm =3D=3D _AUTH_8021x=
_) {
 =09=09=09=09=09=09adapter->securitypriv.binstallGrpkey =3D false;
 =09=09=09=09=09=09adapter->securitypriv.busetkipkey =3D false;
 =09=09=09=09=09=09adapter->securitypriv.bgrpkey_handshake =3D false;
@@ -869,7 +870,7 @@ void r8712_stassoc_event_callback(struct _adapter *adap=
ter, u8 *pbuf)
 =09psta->mac_id =3D le32_to_cpu(pstassoc->cam_id);
 =09/* psta->aid =3D (uint)pstassoc->cam_id; */
=20
-=09if (adapter->securitypriv.auth_algorithm =3D=3D 2)
+=09if (adapter->securitypriv.auth_algorithm =3D=3D _AUTH_8021x_)
 =09=09psta->XPrivacy =3D adapter->securitypriv.privacy_algorithm;
 =09psta->ieee8021x_blocked =3D false;
 =09spin_lock_irqsave(&pmlmepriv->lock, irqL);
@@ -1160,7 +1161,7 @@ int r8712_set_key(struct _adapter *adapter,
 =09=09ret =3D -ENOMEM;
 =09=09goto err_free_cmd;
 =09}
-=09if (psecuritypriv->auth_algorithm =3D=3D 2) { /* 802.1X */
+=09if (psecuritypriv->auth_algorithm =3D=3D _AUTH_8021x_) {
 =09=09psetkeyparm->algorithm =3D
 =09=09=09 (u8)psecuritypriv->XGrpPrivacy;
 =09} else { /* WEP */
diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/r=
tl8712/rtl871x_security.h
index 5727a84838d3..34e5aecf92ae 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -24,6 +24,11 @@
 #define _AES_=09=090x4
 #define _WEP104_=090x5
=20
+#define _AUTH_OPEN_SYSTEM_=090x0
+#define _AUTH_SHARED_SYSTEM_=090x1
+#define _AUTH_8021x_=09=090x2
+#define _AUTH_AUTHSWITCH_=090x3
+
 #define _WPA_IE_ID_=090xdd
 #define _WPA2_IE_ID_=090x30
=20
--=20
2.34.1



