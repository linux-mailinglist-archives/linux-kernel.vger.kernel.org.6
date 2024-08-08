Return-Path: <linux-kernel+bounces-280200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9149294C70F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C261B1C212C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB05C15B103;
	Thu,  8 Aug 2024 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG8N9ntD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5110A1E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723156903; cv=none; b=EV8VzOrz/dLCSnajlmnq/51fmLPVKo+F19Du1GvM6OVLkhEJVhtysy/k1XvZlRUFlERvB0tIFIcX+1iUqjk0PYrWEKJSdnUYxUMtjMpoqngfmAy5p8zkMMhRCZREMaCvkew/jx1eoL4qR6x2oWimFyXKb1FjXt3+dblMGDtn/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723156903; c=relaxed/simple;
	bh=Z9NhZiXiygl+fXMUeW+48aSDSda1CR5oQvoBUfV+O6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jj7/c6elOtPMpMJ5GHU+/AaNINwGz7R1HXxyvjk+bQQEmz3Kmu0TeUpxo8AnqnjC5ZKg/TR2pvjTDZzQ7i9OWLYt/PrcW8l1IMIArqXpJW/BYoBrXieigRBUj4FNaeApSdFrchH5/vTEdtBFLGLmHqFt+w5/pYsXpyEmJ2OEiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG8N9ntD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA8C32782;
	Thu,  8 Aug 2024 22:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723156902;
	bh=Z9NhZiXiygl+fXMUeW+48aSDSda1CR5oQvoBUfV+O6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dG8N9ntDuCt3daKtFqY8qdKCSGa90NdFDgMZqg6RLGQOVQghLcWwbkh7Z/nftw5LI
	 A3lnNxKLafkD8s1hvgga3m5Gx1far4Df3TQlmDa6im83UHDMpM8EZIgE6kyAczMfb+
	 MjSi4d+FagJX88B1tp9GrtCajPvAYfUDLByNBv99/zAjY5vbslV28C4i4+5T8j2xxO
	 Lrtj6L71k5SUhsefA2P6fTHniQj8FDftM4moszW8ZuEyrgG3Kl/+EY6FfmnG8rgjIE
	 x2Hax+AQO4VPTkH1vKKamMED+vAS3ogJ4P5mERl1q5QGIk0qhc3bKhh3cbRKUQqB2r
	 mX89pmbDJRw2w==
Date: Fri, 9 Aug 2024 00:41:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Cleber Rosa <crosa@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20240809004137.01f97da2@foz.lan>
In-Reply-To: <CAFn=p-Y27zap1P5G3NibdZS26iGwCqh8U0vgW0Vw31f53+oU1w@mail.gmail.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
	<CAFn=p-Y27zap1P5G3NibdZS26iGwCqh8U0vgW0Vw31f53+oU1w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Thu, 8 Aug 2024 17:21:33 -0400
John Snow <jsnow@redhat.com> escreveu:

> On Fri, Aug 2, 2024 at 5:44=E2=80=AFPM Mauro Carvalho Chehab <
> mchehab+huawei@kernel.org> wrote: =20
>=20

> > diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> > new file mode 100644
> > index 000000000000..13fae7a7af0e
> > --- /dev/null
> > +++ b/scripts/qmp_helper.py
> > =20
>=20
> I'm going to admit I only glanced at this very briefly, but -- is there a
> chance you could use qemu.git/python/qemu/qmp instead of writing your own
> helpers here?
>=20
> If *NOT*, is there something that I need to add to our QMP library to
> facilitate your script?

I started writing this script to be hosted outside qemu tree, when
we had a very different API.

I noticed later about the QMP, and even tried to write a patch for it,
but I gave up due to asyncio complexity...

Please notice that, on this file, I actually placed three classes:

- qmp
- util
- cper_guid

I could probably make the first one to be an override of QEMUMonitorProtoco=
l=20
(besides normal open/close/cmd communication, it also contains some
methods that are specific to error inject use case:

- to generate a CPER record;
- to search for data via qom-get.

The other two classes are just common code used by ghes_inject commands.
My idea is to have multiple commands to do different kinds of GHES
error injection, each command on a different file/class.

> > +    s =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> > +    try:
> > +        s.connect((host, port))
> > +    except ConnectionRefusedError:
> > +        sys.exit(f"Can't connect to QMP host {host}:{port}")
> > =20
>=20
> You should be able to use e.g.
>=20
> legacy.py's QEMUMonitorProtocol class for synchronous connections, e.g.
>=20
> from qemu.qmp.legacy import QEMUMonitorProtocol
>=20
> qmp =3D QEMUMonitorProtocol((host, port))
> qmp.connect(negotiate=3DTrue)

That sounds interesting! I give it a try.

> If you want to run the script w/o setting up a virtual environment or
> installing the package, take a look at the hacks in scripts/qmp/ for how I
> support e.g. qom-get directly from the source tree.

Yeah, I saw that already. Doing:=20

	sys.path.append(path.join(qemu_dir, 'python'))

the same way qom-get does should do the trick.

> > +
> > +    data =3D s.recv(1024)
> > +    try:
> > +        obj =3D json.loads(data.decode("utf-8"))
> > +    except json.JSONDecodeError as e:
> > +        print(f"Invalid QMP answer: {e}")
> > +        s.close()
> > +        return
> > +
> > +    if "QMP" not in obj:
> > +        print(f"Invalid QMP answer: {data.decode("utf-8")}")
> > +        s.close()
> > +        return
> > +
> > +    for i, command in enumerate(commands):
> > =20
>=20
> Then here you'd use qmp.cmd (raises exception on QMPError) or qmp.cmd_raw
> or qmp.cmd_obj (returns the QMP response as the return value even if it w=
as
> an error.)

Good to know, I'll try and see what fits best.

> More details:
> https://qemu.readthedocs.io/projects/python-qemu-qmp/en/latest/qemu.qmp.l=
egacy.html

I'll take a look. The name "legacy" is a little scary, as it might
imply that this has been deprecated. If there's no plans to deprecate,
then it would be great to use it and simplify the code a little bit.

> There's also an async version, but it doesn't look like you require that
> complexity, so you can ignore it.

Yes, that's the case: a serialized sync send/response logic works perfectly
for this script. No need to be burden with asyncio complexity.

Thanks,
Mauro

