Return-Path: <linux-kernel+bounces-532441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65466A44DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A527A9010
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE692135DC;
	Tue, 25 Feb 2025 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rAbBPoQH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkG9IFJi"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03B4A1E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515782; cv=none; b=llBEHXlNslC2IJ6jRVw8MuPuYsbaEGQoB6EQGprgnw9g+OZxLUs565/KQSHL/lKLDVrj/inzHjPB3/rD8/1DQhnyLDMAMiJqbF8IO/PV0SvhvGTflS1QczNaDjAfxfsZ/lCEfUHW8i6CQEyD9h0Uj3v6bwZDUCRYaaNEn3wcNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515782; c=relaxed/simple;
	bh=J2XYNnf+yOUe3k4gQM0drsOfsUb37QQyfUWGVgTP9vM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qXrEujGzlcOjMh+goL3WEp6U+Y7v5U/GhwhrMlJC+jBucMQGoHI47TGKAnaZhYQVIRvD9dqVdwhFQBXVWzy+APM2I4bT2UpkwILJUvAdI+x2VaiEbvGu/AHg2JlG1Mc3a+BoeBR8OzuuFSyVJjPtTVuNz3WBBUSfQj3uivLTPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rAbBPoQH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkG9IFJi; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C6941380A38;
	Tue, 25 Feb 2025 15:36:19 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 15:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740515779;
	 x=1740602179; bh=7D6bJfmXOGzdLvZy1vlb2xlVVaSEYnFr82KLKUChPY8=; b=
	rAbBPoQH11CHKHyUr0RELVm34qQSrNSNm+EvdAhA/XQ4PNwnk5aOex5emNXiwbvk
	0un6wFPwOL/eXuYgqRwLvtTj7er3n5Gy4jROr9p8Zl+Tyib22UyAm4xMw/jYntc9
	5pMDeMMUeiq+6bejmRhSBgaAsC5KIDn2y3gNUwGxcbYwj2VAYJAPevbsuwFg67do
	zsYvIRtP55yNGE+OAf4p40qZlDoUabtYfrj6slFReOB7eKI5SpbNNuW5hvvGw2k/
	dI0jfRof5uyNGuTKKO91dEpvcFf4mrxNO5cUsD+ntqiM2Y5gwTuSiZL3ILXptpQA
	yGsT/97YEMWB+NffPuTz+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740515779; x=
	1740602179; bh=7D6bJfmXOGzdLvZy1vlb2xlVVaSEYnFr82KLKUChPY8=; b=X
	kG9IFJiTjJs14yVFZDzYsJNs7EaVYZRl4JEStaxfLTaIabVoexI0otEpl8LnIEgP
	FrRTWwlCwV90IHznNA3h2a/l+cZr1WaDbkzad85bU6P35WHkMBjas1uphbyiBjm5
	+t6Eeakl5Ok698LgzaSjDrAb/ldMiekucJls3cB+jdpYwDIKHlr/DNyi+/dl852+
	XEaA9mcEtTXXb7RkWhzIqlsU3K0bfqqQ5tDT6gMCILHHwnGFiNaHrr/Lw0fXsyZz
	FyzFZYlYqbCDiMcc8S/BHJF/yxAZfekIoXqQjVnTiRYhtoreLJ1ESZOl8gMtl5fK
	Z6BcovI7+b0T0gakByiKg==
X-ME-Sender: <xms:wim-Z9DtxNbK3DsuI8S-dAS5saT-y3T-a3VW4-QU2e4lJllYG50tMA>
    <xme:wim-Z7g9OEN9_uYtLd4nenKKQAjyllQsL4LzeyRW_Fwt510OyPW-CkgT4Z0ppnJHc
    E3g9R3BP1Uy8Si1vXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepuggvvhgvlheslhhishhtshdrohhrrghnghgvfhhsrdhorhhgpdhrtg
    hpthhtohephhhusggtrghpsehomhhnihgsohhnugdrtghomhdprhgtphhtthhopehmrghr
    thhinhesohhmnhhisghonhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtohhphhgv
    rdhjrghilhhlvghtseifrghnrgguohhordhfrhdprhgtphhtthhopehvihhrohesiigvnh
    hivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:wim-Z4nvZZPpY4TtFhyd1mCPoKAsn3bhs-Ty62_78Z4Jz0c_7WlaLQ>
    <xmx:wim-Z3x_yzxr6iOzQEhDnT_xhW312zdVqzr7lkxgiGlokaJU3702Wg>
    <xmx:wim-ZyR0wgFAyphUbGIowmnmr1j2a8VXzMEyJ1Lrf2qhvSSk4QRUTQ>
    <xmx:wim-Z6ZnOj4Rsjn21J4Q_C6blLzic47SpxqHLt2ovBzht7Gs_DHOAw>
    <xmx:wym-Z_SljGvPzzGiuZq_a-sWn7Rrc-JJ_r3FMPHup926LSf7r0zV4a89>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 53B2B2220072; Tue, 25 Feb 2025 15:36:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 21:35:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
 "Arnd Bergmann" <arnd@kernel.org>, "Mike Marshall" <hubcap@omnibond.com>
Cc: "Martin Brandenburg" <martin@omnibond.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, devel@lists.orangefs.org,
 linux-kernel@vger.kernel.org
Message-Id: <def39f2c-abc0-457b-9807-9a76e7da3161@app.fastmail.com>
In-Reply-To: <dd1a326a-e165-4796-9005-6bff2019deef@wanadoo.fr>
References: <20250225200901.4041575-1-arnd@kernel.org>
 <dd1a326a-e165-4796-9005-6bff2019deef@wanadoo.fr>
Subject: Re: [PATCH] orangefs: move s_kmod_keyword_mask_map[] into debugfs.c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025, at 21:24, Christophe JAILLET wrote:
> Le 25/02/2025 =C3=A0 21:08, Arnd Bergmann a =C3=A9crit=C2=A0:
>> From: Arnd Bergmann <arnd@arndb.de>

>> + *      .           .           .
>> + */
>> +static struct __keyword_mask_s s_kmod_keyword_mask_map[] =3D {
>
> Unrelated to your patch, but I think that this could be made const.
>

Right, but not trivially, probably something like the change below.

There are obviously countless variables that should be const.

     Arnd

--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -73,7 +73,7 @@ struct __keyword_mask_s {
  *     qux          8           3
  *      .           .           .
  */
-static struct __keyword_mask_s s_kmod_keyword_mask_map[] =3D {
+static const struct __keyword_mask_s s_kmod_keyword_mask_map[] =3D {
        {"super", GOSSIP_SUPER_DEBUG},
        {"inode", GOSSIP_INODE_DEBUG},
        {"file", GOSSIP_FILE_DEBUG},
@@ -131,7 +131,7 @@ static int orangefs_prepare_cdm_array(char *);
 static void debug_mask_to_string(void *, int);
 static void do_k_string(void *, int);
 static void do_c_string(void *, int);
-static int keyword_is_amalgam(char *);
+static int keyword_is_amalgam(const char *);
 static int check_amalgam_keyword(void *, int);
 static void debug_string_to_mask(char *, void *, int);
 static void do_c_mask(int, char *, struct client_debug_mask **);
@@ -764,7 +764,7 @@ static void do_k_string(void *k_mask, int index)
 {
        __u64 *mask =3D (__u64 *) k_mask;
=20
-       if (keyword_is_amalgam((char *) s_kmod_keyword_mask_map[index].k=
eyword))
+       if (keyword_is_amalgam((const char *) s_kmod_keyword_mask_map[in=
dex].keyword))
                goto out;
=20
        if (*mask & s_kmod_keyword_mask_map[index].mask_val) {
@@ -811,7 +811,7 @@ static void do_c_string(void *c_mask, int index)
        return;
 }
=20
-static int keyword_is_amalgam(char *keyword)
+static int keyword_is_amalgam(const char *keyword)
 {
        int rc =3D 0;
=20

