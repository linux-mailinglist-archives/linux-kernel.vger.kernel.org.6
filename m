Return-Path: <linux-kernel+bounces-546758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C099EA4FE62
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B08C3AC9D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948224291B;
	Wed,  5 Mar 2025 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d03ForTP"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FF23C8BB;
	Wed,  5 Mar 2025 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176916; cv=none; b=I4foAmzeU5HvwRN3Z/vhjFzv1GChSwtN6dyi/oJl/XBzJW/FpmFFWr/xc/VoETDd2IFNiyap35QdNQGllj2xzBOrP0h3KYm7m7kL2ERNxGv72Pu1xvsL+mGcAnTGLl2DSfsXhNqraruYlL2Xx5PURzJuBxaD3wxHjgyqvs7LQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176916; c=relaxed/simple;
	bh=V/ld7OvVo2UL7AU2pdyRHRzo28A784GsT7PelHMFnHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFiD/YRiP8ggLoL/nnIQLSjxESpWJ3GD5/gZNdAmbM0xmdCoUCoYcUltIPs/orcTdIHF5N8j0n9mi9X8Adedxj3zn83+mpftULhbk4EJHV1/JYuGQ32SsWFh3XSBNjtywMrEk+3yO6bxbm/KS1Bnhy1Ppj42E+AVasa27vG3Ua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d03ForTP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5253kITe016833;
	Wed, 5 Mar 2025 12:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Pm6F2n
	awClcjd4E+QSzQyjWDwBTls/5MGhyorHFhCfo=; b=d03ForTPwglSKS8Naz1zTr
	Fbp+0SwrqthMxadZGLyZlzdmaAsWsYjrRzPHkVJfaRrGjJ0N9eSJLYRuXL5VjYNQ
	wSU9LYqqPHtbLmuUTAEpaiMOVrWYSzY/c1/40J7iZgV5MufdllLctaCaG1J6GZNE
	2uP5yi2LlBbSJUx+hDMp4VIFvfO/F53XvXG5G64Cx3Ov6siUPdiKUdSud1i/xTPz
	kCq2lLfRATBT4tGlNbbmxHFN8NBAY43rHq1tFDsozH+lO6ISOvU+Gzvlei/E0lKT
	HLQfHSRb0lcR2qId5ctB2pHaoUN/3A3XoDf4C4AYhfwglTFPlLKWI41lYyDS8PjQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456f08t4c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 12:15:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525AVqsW032680;
	Wed, 5 Mar 2025 12:15:06 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjt2wr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 12:15:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525CF5fu31130222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 12:15:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DC6E58055;
	Wed,  5 Mar 2025 12:15:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BED835804B;
	Wed,  5 Mar 2025 12:15:03 +0000 (GMT)
Received: from [9.152.212.232] (unknown [9.152.212.232])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 12:15:03 +0000 (GMT)
Message-ID: <12d78b156c65130c60503b3925b4440d570fa245.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
        Amit Shah	
 <amit@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        pasic@linux.ibm.com
Date: Wed, 05 Mar 2025 13:15:02 +0100
In-Reply-To: <35286574f42ae6a413eaca14633a11d50cbadb2b.camel@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
			 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
		 <67efe42ea8c10120f13f14838f7a3d883184ecf5.camel@linux.ibm.com>
	 <35286574f42ae6a413eaca14633a11d50cbadb2b.camel@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JFHtFI-cMfcJL81L55I2Iycm1LlYIMPn
X-Proofpoint-GUID: JFHtFI-cMfcJL81L55I2Iycm1LlYIMPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_04,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050097

On Wed, 2025-03-05 at 13:13 +0100, Niklas Schnelle wrote:
> On Wed, 2025-03-05 at 10:53 +0100, Maximilian Immanuel Brandtner wrote:
> > On Mon, 2025-03-03 at 12:54 +0100, Amit Shah wrote:
> > > On Tue, 2025-02-25 at 10:21 +0100, Maximilian Immanuel Brandtner
> > > wrote:
> > > > According to the virtio spec[0] the virtio console resize struct
> > > > defines
> > > > cols before rows. In the kernel implementation it is the other way
> > > > around
> > > > resulting in the two properties being switched.
> > >=20
> > > Not true, see below.
> > >=20
> > > > While QEMU doesn't currently support resizing consoles, TinyEMU
> > >=20
> > > QEMU does support console resizing - just that it uses the classical
> > > way of doing it: via the config space, and not via a control message
> > > (yet).
> > >=20
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/char/virtio_console.c#n1787
> > >=20
> > > https://lists.nongnu.org/archive/html/qemu-devel/2010-05/msg00031.htm=
l
> >=20
> > I didn't know about this patch-set, however as of right now QEMU does
> > not set VIRTIO_CONSOLE_F_SIZE, never uses VIRTIO_CONSOLE_RESIZE, and
> > resizing is never mentioned in hw/char/virtio-console.c or
> > hw/char/virtio-serial-bus.c. Suffice to say I don't see any indicating
> > of resize currently being used under QEMU. Perhaps QEMU supported
> > resizing at one point, but not anymore. If you disagree please send me
> > where the resizing logic can currently be found in the QEMU source
> > code. I at least was unable to find it.
> >=20
> > >=20
> > > > diff --git a/drivers/char/virtio_console.c
> > > > b/drivers/char/virtio_console.c
> > > > index 24442485e73e..9668e89873cf 100644
> > > > --- a/drivers/char/virtio_console.c
> > > > +++ b/drivers/char/virtio_console.c
> > > > @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> > > > virtio_device *vdev,
> > > > =C2=A0 break;
> > > > =C2=A0 case VIRTIO_CONSOLE_RESIZE: {
> > > > =C2=A0 struct {
> > > > - __u16 rows;
> > > > =C2=A0 __u16 cols;
> > > > + __u16 rows;
> > > > =C2=A0 } size;
> > > > =C2=A0
> > > > =C2=A0 if (!is_console_port(port))
> > >=20
> > > This VIRTIO_CONSOLE_RESIZE message is a control message, as opposed
> > > to
> > > the config space row/col values that is documented in the spec.
> > >=20
> > > Maybe more context will be helpful:
> > >=20
> > > Initially, virtio_console was just a way to create one hvc console
> > > port
> > > over the virtio transport.=C2=A0 The size of that console port could =
be
> > > changed by changing the size parameters in the virtio device's
> > > configuration space.=C2=A0 Those are the values documented in the spe=
c.=20
> > > These are read via virtio_cread(), and do not have a struct
> > > representation.
> > >=20
> > > When the MULTIPORT feature was added to the virtio_console.c driver,
> > > more than one console port could be associated with the single
> > > device.
> > > Eg. we could have hvc0, hvc1, hvc2 all as part of the same device.=
=20
> > > With this, the single config space value for row/col could not be
> > > used
> > > for the "extra" hvc1/hvc2 devices -- so a new VIRTIO_CONSOLE_RESIZE
> > > control message was added that conveys each console's dimensions.
> > >=20
> > > Your patch is trying to change the control message, and not the
> > > config
> > > space.
> > >=20
> > > Now - the lack of the 'struct size' definition for the control
> > > message
> > > in the spec is unfortunate, but that can be easily added -- and I
> > > prefer we add it based on this Linux implementation (ie. first rows,
> > > then cols).
> > >=20
> > > But note that all this only affects devices that implement multiport
> > > support, and have multiple console ports on a single device.=C2=A0 I =
don't
> > > recall there are any implementations using such a configuration.
> > >=20
> > > ... which all leads me to ask if you've actually seen a
> > > misconfiguration happen when trying to resize consoles which led to
> > > this patch.
> > >=20
> > >  Amit
> >=20
> > I'm working on implementing console resizing for virtio in QEMU and
> > Libvirt. As SIGWINCH is raised on the virsh frontend the new console
> > size needs to be transfered to QEMU (in my RFC patch via QOM, which
> > then causes QEMU to trigger a virtio control msg in the chr_resize
> > function of the virtio-console chardev). (The patch-set should make its
> > way unto the QEMU mailing-list soon). The way I implemented it QEMU
> > sends a resize control message where the control message has the
> > following format:
> >=20
> > ```
> > struct {
> >     le32 id;    // port->id
> >     le16 event; // VIRTIO_CONSOLE_RESIZE
> >     le16 value; // 0
> >     le16 cols;  // ws.ws_col
> >     le16 rows;  // ws.ws_row
> > }
> > ```
> >=20
> > This strongly seems to me to be in accordance with the spec[0]. It
> > resulted in the rows and cols being switched after a resize event. I
> > was able to track the issue down to this part of the kernel. Applying
> > the patch I sent upstream, fixed the issue.
> > As of right now I only implemented resize for multiport (because in the
> > virtio spec I was only able to find references to resizing as a control
> > message which requires multiport. In your email you claimed that config
> > space resizing exists as well. I was only able to find references to
> > resizing as a control message in the spec. I would love to see what
> > part of the spec you are refering to specifically, as it would allow me
> > to implement resizing without multiport as well).=20
> > It seems to me that either the spec or the kernel implementation has to
> > change. If you prefer changing the spec that would be fine by me as
> > well, however there seems to be no implementation that uses the linux
> > ordering and Alpine seems to patch their kernel to use the spec
> > ordering instead (as described in the initial email)(this was really
> > Niklas Schnelle's finding so for further questions I would refer to
> > him).
>=20
> I don't think this was patched in the (official) alpine kernel. What
> happened is that I tested TinyEMU[0] with the kernel + initrd from the
> JSLinux site and that has working console resizing. In the TinyEMU code
> this is implemented in TinyEMU/virtio.c:virtio_console_resize_event():
>=20
> void virtio_console_resize_event(VIRTIODevice *s, int width, int height)
> {
>     /* indicate the console size */
>     put_le16(s->config_space + 0, width);
>     put_le16(s->config_space + 2, height);
>=20
>     virtio_config_change_notify(s);
> }
>=20
> On second look this indeed seems to use the config space. It writes
> first the width then height which matches config_work_handler(). But
> like Maximilian I could only find the VIRTIO_CONSOLE_RESIZE message
> mechanism in the spec, also with width (cols) then height (rows) but
> not matching the kernel struct changed by this patch.
>=20

Forgot to note, the idea that Alpine was patched came because the
kernel used in TinyEMU has '-dirty' in the local version so we were
wondering if it was patched for this. But seeing the
config_work_handler() it's probably just using that.

Thanks,
Niklas

