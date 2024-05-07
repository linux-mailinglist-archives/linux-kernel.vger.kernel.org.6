Return-Path: <linux-kernel+bounces-170642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637F8BDA1E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5340284E12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56774F888;
	Tue,  7 May 2024 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fdxIWxkC"
Received: from sonic306-22.consmr.mail.ne1.yahoo.com (sonic306-22.consmr.mail.ne1.yahoo.com [66.163.189.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9A4EB56
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055631; cv=none; b=fNS5Uaey0Bed9hIQN6ht/nbmYXePYidmEsFl2+ZNVEpKAXzNvCcWQdSGR5AmU8nnRV3qSCl0TGw+h/9BziMdtrZERtP56ASNldzD9U4LTd1O/IcDNNuck2LnHUCN+edRB848DojdVFuMclT2r5uJHdy46H9/cv6GZyLokvizvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055631; c=relaxed/simple;
	bh=yBd5iJJkhGCtWrRHHUh2Cy7RfSiIGU4wuvSAFtG2uYg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:References; b=OLk4Yn7l3zfme+YrlVe7GZ8v+stJsJYCjoDb5f/TrFbah4dCsnkYmHw/80vjvEg1k5Dl4tZL/kP0BWfNOlLawKixxiccKOBVY+TgLxmnKJ6n5ZE9e+WrFA/tDVB8N0v+TuDgxcOE1E0BKWnlq3QXtnwdbP88Tgcn8lQYQnZ4cxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fdxIWxkC; arc=none smtp.client-ip=66.163.189.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715055623; bh=yBd5iJJkhGCtWrRHHUh2Cy7RfSiIGU4wuvSAFtG2uYg=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=fdxIWxkC9DKL2A8k+SwzyW+WvETTiI0M41Q0nN/zugR2eo5dnrxeXD/ueykYRXgJQiHoyNjmhHWoaZ4D+X8pz3qSA5nFGfGWrw6+dETkEs9M9sZpNh3GRz7SIRqzzjTWjOgd8LUFUpbkZu9v2tWY6tTsY7vsnC7xczhOxBMtmiZpF8U6MlW0B7i4cg0NcIqh+vYOtbO2VwYEhXJYtbF6U3QffoXyE+N/I45uJvhfVXUBBsCCLUXPfIwZEMzI7VH7tQ5vfYGxz/rJmM7TAEHZgEklGhlvYYptNO5YqLLK87G/r2Pq8bFs9pvzRdTL/YpaQ7MCLsdXQoEFLy5+uV+DzQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715055623; bh=9bazwOmnXQMosmZhC0nI7UqxY1qvbKFBdZB+wLLJbBA=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=HXv+SO2cOQCq7vNs1MlXC9vDVIyvQuFscQSEzbQLjSr89ucplZOJPM/q3U8jcitWQ872eJwkvGDAzWwXk+2IVS+bGZrfiVsaL/7+M/tj8FxHn1j9BmxeY8Xq/Qa45D4RsHZawG0IR/uG8HKkSaKvncfnu6m3xDHBDcr/2C8Y6ie/f/geYQoyjquKv4GG4hM8P0vsZWSHPY0gO58cG9VSUnbM7Aml495EjgB374VsWynExhJNSaZJN8oq9fwifyXugo/2r8bQ9KC+qa1FgP3ZkosTgfM/Ur8yAMYPOp0cNYeQk4CRyjDLqfSaPWTZR6+HpHB62YZ0YCyl1W5trnCm7A==
X-YMail-OSG: twiscKMVM1m7dUmQ9FUKnkYtR7D_os1WXueeBU2EZbGlzma1rND7t_VXk7m.Kw6
 Lq3kVUPADUDEfl6ZyvZDAr4O9LvpAFJelVq9V9ggg45rYwM3lmq6cPQV1adFBmOC3NjUMeVC8WbN
 ur5b7W3u6UsWtIfo_AQAl2XZtmS2R67wrc8H0mrxoSzDUDsvDGy96H47zWY4PHykv6X3fV136kXn
 Hcz2Ce5daWioqe8kzgKctXgGxEI6JHuXQj2ZUxHXYDqCZ_APeCpH89ieg5zJEMj1er0Xd02buwhY
 ZqKsfLsFroueBwCsicBz4h9gXQ6hCbgsyMfWtQo.LTQ21r3S5BvsioIME_CXqxy68YtNyOc8OWXp
 VKNHPs1e9C3iL6E.mBcLxLEM7di3B0eLbT2WHKUfYE8QGISdjwlJCA408NSKhBo1MeAFd_s0pV4q
 MO.2qtpC9CelljZnYiwfGuRoz5zCsEqL.2tMmP3gcTUGuSXC3W73nPIYUgUI9yOpCyRRO8Vb6esT
 2rPjcUvetXGuq3gN7Q9YQRtVg29hQWvOq7UUjurShm__GddfgXfBhr06tjoCh8Aj_r2iA5t.8wM7
 PWBTy99hx0C7DX47MMJz6mQmVGdiSRzmgbpkYBqn8bn9g1ZW9SAMBLffBWJaG5g2LIdu90ySXMrU
 JXunFAEKyK8bt6P_D8ztX8dSlbeTThu4HDcH3FVgJp1qa7TEsIWsupYMRS8MQwiNLTLeAkXCTd3g
 6lwjn.y7vq9vCNjdZEDkj.LzcFlsEKeIddS.nXt0M2WA1pCprBWyyqI3foQVEqDNfsuQYVldIA3D
 mNIaT9EcwKG_w95hHTQS_Sv_EBbxmYBW6RsJlylAC_FlsQHFM4naddCdISsymapPlk.qof8gzVfD
 k2V737Z2PskCTrCarscZFjMEwD9FEKI6TTVMcbA6xWy6Tt.DKm8lstjKiKWjk_VuHC3ExGZL.QV5
 HWlFc.mWIJjeMPK4ZJIlEHsB4itfUl14.BIOGvs.x3STyrydWXhy4aYQSpa7kmJfteQ7JF3QOudd
 eW2VEIjgTjq68v5NEvsqP3x6UnKDxYOsBPDQGfx1cF7q6qBRaGXvLn24IHL7340BFSQchj6h7jA0
 HNIPDEoh5zfixKotbABPiKCi262FF34.XSA3Hwna0UWuK8iRLqQ3L8o3rss9kYVBdG1bYrq8ZBJD
 c5kkwE7SPmvBgU2EmsO4O1UthYTLowof9pGd1o9ucDLi7x2Un_G8Qhyv9r0aHdUQhNElNzwo._Gq
 YMY.sMxIfS40ec5V2rovMhxiSAYKPYe3.o7kNrm9x9Gl1jC8NNPhdsk43QjgmME8aL9qzPti6Hw8
 aHZ2Zp0VYUeW82YbUd3B52hIc31jbOwu9DqtB7BGYaYewZZmgRFfJzSLCBRhi58IiiHjX07v7mPC
 O.Z4Bi2hwGwY.ib6gqJNaBQjmAo3F3..vyU5oooxIbpizR8Kw_rv3cERtbiEDGBAX9spReKEjNs1
 nMIvIkDtwybkiWOMZWyyQFQWKgpGJ3tVEvXsNJ9RyzEmxCbLscpoxOj69yXLUxRJhNWqgQqUl_8Q
 H8x0qobmAOWG7nOK5m.wav7th_cUjbCJB4xLGRSITSp48hAHpiysich4utTuh6DXe7ym2s0XUng4
 znUNfJVX.6CLCzf9VzQe8n1zUbOE8WOPKrhTDfQz3s5wDUP4lwDTAmVxlj1F1C9mvm_W_z8Ug5vv
 POJfyM52fMOaFJZ3b1qdH2dC1Kvdt.i19igCx6VgRuJDfZUBGr.eeJJaIlJXrw74rMuHKYaVadTM
 tWKZFtA8I5_XxC9Qi02X5xDmV1J4owAISJvUxqCJkJtM7Ssn1vyRE1HbKoBJboh8IMeWqX2c_PSI
 .x3hfrDOvvxG3uv7H3H_u6Yon6hXl1KfGEnGgu7JrKt_7QcyCuzEiUnHuaOrew8t_yco6Rh_ryfo
 HSHhXbGITo3sD0cfYVE3iI2M8kZbTXjMi7FJflOK_3y3mpBwdnjeyxxNrrLldlN17Nbkdaggn1MS
 CKwERrCssQP4HMuL9UFZAohiTP6izjxXCdLZ4RTIYti2_pF.On5EwQ2sQmR5MlGz7x.8RaRS.50G
 TvqTM92krChUkRVhYDmR1DAIX0PJgjfImvZX7qsVhdxYsOeF9cddVwJRQPrC7JXzZe9.fG.dh_Qg
 PHipYLDEDK2LVgx4oKjS2.ZWZgBG80WPg7EkujMs5VE1.a7eujIj0oInv1f0JXb2gwLgbBDZ5nHr
 ZwmwJ5nm_KHMqvwosqez1Kl2VS4wlUHqzHr8RxtexAD4AjaRZnRd0l.5BZv83xQfqCEMJuPq9f14
 -
X-Sonic-MF: <ashokemailat@yahoo.com>
X-Sonic-ID: 10a2b099-89fc-4124-bf07-605818fdfc44
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 May 2024 04:20:23 +0000
Received: by hermes--production-bf1-5cc9fc94c8-qql8s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 88b0ea99ab69fea61943fcb9ca83817a;
          Tue, 07 May 2024 04:20:20 +0000 (UTC)
Date: Mon, 6 May 2024 21:20:17 -0700
From: Ashok Kumar <ashokemailat@yahoo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: [RFC] CamelCase can it be fixed per Checkpatch.pl script
Message-ID: <ZjmsAVlZmA5sje/Y@c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mtxt
References: <ZjmsAVlZmA5sje/Y.ref@c>
X-Mailer: WebService/1.1.22256 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Found some files in Staging Drivers for which checkpatch.pl throws a CHECK to
+remove CamelCase.

For instance in program vt6655/card.c find the usage of CamelCase as
i) Variable names eg: &priv->apTD0Rings[0]
ii) Function names eg: void CARDvSafeResetRx(

Note: some of the functions are
+static functions

Reviewed lore and seems in some instances removing CamelCase was allowed and in
+some case removing them was disallowed.

Hence wanted comments if we should change them or not.

Thanks
Ashok


