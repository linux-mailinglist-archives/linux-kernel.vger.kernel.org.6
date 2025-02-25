Return-Path: <linux-kernel+bounces-531053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC9AA43BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A48424B39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767DC26739C;
	Tue, 25 Feb 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA+Re3qo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4D266B62;
	Tue, 25 Feb 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479024; cv=none; b=R7mXsi1WmoubIqdpWM0zAOR2b901IhnVX0tMyRDG55GqsegpbVX5+QpN8qbGu3lrRpI/DvMZfpDT0jE7292jWI5DipdSvVYVKBrAjUr5o+z6ljy2QLcAQYXHKxEttKRmO1WRCFKSztTwCFSjm0h2MU5w20DceheSVHj8jZsY2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479024; c=relaxed/simple;
	bh=OL7+WhfqMOlCT5NqZZrkzMvgJrl1fo1sSNbR/WMWItM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NoOv9x/UW7hE8ptCB26fj0NMMk/1r4VinNUNlaR2RSwu6zd2kSB0KiE4qijY0yofY9X//9OSTdwA7FaaN8450ZOGt7cz4a1+YpIv+ZgoPzSgkMhCPB2jnKjlubTrUBAHTaRAp2pORCuM0r/W1HsKZBrHw8JomY/IV+1lHR7K8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA+Re3qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86CBC4CEDD;
	Tue, 25 Feb 2025 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740479023;
	bh=OL7+WhfqMOlCT5NqZZrkzMvgJrl1fo1sSNbR/WMWItM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VA+Re3qoylvKvbXFzQkmRV9ABh85iVOXJub7z4pDJrhRZKI02nzLKpC0uTXFu4LMB
	 /hB8zIW+EKnR03s6TiKoNzE7TwW6mSrZfs4TnLg2s9DACupBAna/Mc2NlUzYUDPk7i
	 KRP+LjahDFczzI3mFxrX/YdUXNWwZf0558obPR/XL2WVsT6yj6K3tyyk3t6koeACdb
	 nQnskVCEXPLRKnIEWQASvJj/Zmre9YYpu8z3TgN+tVWIeEgwgraNVrXU2uc5hHji5u
	 yGJaFP1yJd1DUkkkrvkiG6ReScTr/14o+umXrzA1UK82R57hQg/9Zazmg83lAGq7Ah
	 0rX4i/11wpDAQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Joel Becker" <jlbec@evilplan.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Peter Zijlstra" <peterz@infradead.org>,  "Ingo Molnar"
 <mingo@redhat.com>,  "Will Deacon" <will@kernel.org>,  "Waiman Long"
 <longman@redhat.com>,  "Fiona Behrens" <me@kloenk.dev>,  "Charalampos
 Mitrodimas" <charmitro@posteo.net>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] rust: configfs: add a sample demonstrating
 configfs usage
In-Reply-To: <CB975A56-A8D5-4615-8755-04D7B0BBBCA5@collabora.com> (Daniel
	Almeida's message of "Tue, 25 Feb 2025 06:37:33 -0300")
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
	<20250224-configfs-v4-3-9af9b5e611f6@kernel.org>
	<gFsQNuXNmyVQmdawZnfoGhTe3Fu7W0K5VeoiM5tjROpKWVojf48IOHIQT0JY77AFiTPPLHk3f_gjzEGilH7vLQ==@protonmail.internalid>
	<CB975A56-A8D5-4615-8755-04D7B0BBBCA5@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 11:23:30 +0100
Message-ID: <87jz9ewcf1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Andreas,
>
>> On 24 Feb 2025, at 10:21, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Add a sample to the samples folder, demonstrating the intended use of the
>> rust configfs API.
>
> nit: this is not the first time I see Rust not capitalized in this series.

Will fix =F0=9F=91=8D

[...]

>> +impl kernel::InPlaceModule for RustConfigfs {
>> +    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
>> +        pr_info!("Rust configfs sample (init)\n");
>> +
>> +        let item_type =3D configfs_attrs! {
>> +            container: configfs::Subsystem<Configuration>,
>> +            data: Configuration,
>> +            child: Child,
>> +            attributes: [
>> +                message: 0,
>> +                bar: 1,
>> +            ],
>> +        };
>
> As I said in the previous patch, this macro is a bit complex. Is there an=
ything more you can do with it?
>
> If so, it better be in this driver, because I hardly think anybody will g=
o through the source code itself
> to figure out. My 2c.

I can add some inline comments on the usage here. Is that what you are
thinking of?

>
>
>> +
>> +        try_pin_init!(Self {
>> +            config <- configfs::Subsystem::new(
>> +                c_str!("rust_configfs"), item_type, Configuration::new()
>> +            ),
>> +        })
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::GroupOperations for Configuration {
>> +    type Child =3D Child;
>> +
>> +    fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::=
Group<Child>, Error>> {
>> +        let tpe =3D configfs_attrs! {
>> +            container: configfs::Group<Child>,
>> +            data: Child,
>> +            child: GrandChild,
>> +            attributes: [
>> +                baz: 0,
>> +            ],
>> +        };
>> +
>> +        Ok(configfs::Group::new(name.try_into()?, tpe, Child::new()))
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::AttributeOperations<0> for Configuration {
>> +    type Data =3D Configuration;
>> +
>> +    fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> R=
esult<usize> {
>> +        pr_info!("Show message\n");
>> +        let data =3D container.message;
>> +        page[0..data.len()].copy_from_slice(data);
>> +        Ok(data.len())
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::AttributeOperations<1> for Configuration {
>> +    type Data =3D Configuration;
>> +
>> +    fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> R=
esult<usize> {
>> +        pr_info!("Show bar\n");
>> +        let guard =3D container.bar.lock();
>> +        let data =3D guard.0.as_slice();
>> +        let len =3D guard.1;
>> +        page[0..len].copy_from_slice(&data[0..len]);
>> +        Ok(len)
>> +    }
>> +
>> +    fn store(container: &Configuration, page: &[u8]) -> Result {
>> +        pr_info!("Store bar\n");
>> +        let mut guard =3D container.bar.lock();
>> +        guard.0[0..page.len()].copy_from_slice(page);
>> +        guard.1 =3D page.len();
>> +        Ok(())
>> +    }
>> +}
>> +
>> +#[pin_data]
>> +struct Child {}
>
> nit: you don=E2=80=99t need the braces here

Can't do that. The `pin_data` macro won't eat it. I'll add a comment.

>
>> +
>> +impl Child {
>> +    fn new() -> impl PinInit<Self, Error> {
>> +        try_pin_init!(Self {})
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::GroupOperations for Child {
>> +    type Child =3D GrandChild;
>> +
>> +    fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::=
Group<GrandChild>, Error>> {
>> +        let tpe =3D configfs_attrs! {
>> +            container: configfs::Group<GrandChild>,
>> +            data: GrandChild,
>> +            attributes: [
>> +                gc: 0,
>> +            ],
>> +        };
>> +
>> +        Ok(configfs::Group::new(
>> +            name.try_into()?,
>> +            tpe,
>> +            GrandChild::new(),
>> +        ))
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::AttributeOperations<0> for Child {
>> +    type Data =3D Child;
>> +
>> +    fn show(_container: &Child, page: &mut [u8; PAGE_SIZE]) -> Result<u=
size> {
>> +        pr_info!("Show baz\n");
>> +        let data =3D c"Hello Baz\n".to_bytes();
>> +        page[0..data.len()].copy_from_slice(data);
>> +        Ok(data.len())
>> +    }
>> +}
>> +
>> +#[pin_data]
>> +struct GrandChild {}
>
> =E2=80=A6nor here

>
>> +
>> +impl GrandChild {
>> +    fn new() -> impl PinInit<Self, Error> {
>> +        try_pin_init!(Self {})
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::AttributeOperations<0> for GrandChild {
>> +    type Data =3D GrandChild;
>> +
>> +    fn show(_container: &GrandChild, page: &mut [u8; PAGE_SIZE]) -> Res=
ult<usize> {
>> +        pr_info!("Show baz\n");
>
> As I said in the cover letter, perhaps this one slip through :)

Yes, thank you.

>
>> +        let data =3D c"Hello GC\n".to_bytes();
>> +        page[0..data.len()].copy_from_slice(data);
>> +        Ok(data.len())
>> +    }
>> +}
>>
>> --
>> 2.47.0
>>
>>
>
> I=E2=80=99m OK with this patch. It works, and it does what it=E2=80=99s s=
upposed to do, i.e.: showcase the API.
>
> With the =E2=80=9CShow baz=E2=80=9D nit fixed:
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Thanks!


Best regards,
Andreas Hindborg



