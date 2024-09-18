Return-Path: <linux-kernel+bounces-332785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02897BEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E06281CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1D1C8FC6;
	Wed, 18 Sep 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MYH2y8oH"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B42AEEE;
	Wed, 18 Sep 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726674062; cv=none; b=EBUcrqg4dF8NlcJWKQHgbp+0voEWcGaWMApc2RI+4asKAsn0KEY+gukCUciUpFSrE2vqUIaZJhGw7nLuOkmb4SwJ8ro9OvDya2d+Yo2J3WRceTUaunYpraj5tkGmI8rp833R8tkWy7QBrVz1RWC+BmEhPmdBuPNZQp6uiG2c40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726674062; c=relaxed/simple;
	bh=1rF47UtHEQJ137LrasUeTbvsBTVY9duaBBEhEXIBuQc=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otCkXOQ0sH8OdXE4u2TOuDNoVoK2Y2Vt168ZZOyfTJLHYfex7JrmidRAhETpPnTEhOOD1mGjyAQ0nvAFfnHOC63wm1zm0DFkeW4IDZCtogE5uV3uZeI235BAdlzThA3iuDhObmOm/TzTWib/O2aCNiDTqjl1hA9xtxe2Fw6Zlm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MYH2y8oH; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726674057; x=1726933257;
	bh=8IS+pb8eNNErZyVAliOpCQKiJ9F3/u805t0k80/mo/M=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MYH2y8oHENN/XM4VftyXOFbEOvP3Hwlo9YVhtjY46gSqmn7CBFVHJXaYHidDVB1YM
	 rrqNLCea0SFFJp8WZxhE3zLqrzk6EIfGKvTIvE4iLfPjH1Z4aOlfgDJtPtHu5+h9Zp
	 FX58scyWw0Q1y1A8ty92Nq/Iw2/6Ix7qo29G2Pn4JDx4zhagoFIg/XlcjU9Y7asZ/T
	 TWGKVYM9V314k9PCVLrOYbbr2yIWZqzs0OAtkn9a8hLCCbxZeM2JOQAfNO4VfB0pXw
	 DK+FuoJpvj9aKXYG3IlPzsYtEPKDtkCL9+Ivmqyveuq784lIsS29O1YTArADxhVbnc
	 6YcYuVtmm4wIA==
Date: Wed, 18 Sep 2024 15:40:54 +0000
To: Simona Vetter <simona.vetter@ffwll.ch>, Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH 1/3] rust: add untrusted data abstraction
Message-ID: <26534d80-989d-4b77-9720-84575275890f@proton.me>
In-Reply-To: <ZuhTdwCqz61bQEgq@phenom.ffwll.local>
References: <20240913112643.542914-1-benno.lossin@proton.me> <20240913112643.542914-2-benno.lossin@proton.me> <ZuRbSxwlz1xWT1pG@phenom.ffwll.local> <cf0d6189-e81c-4b7c-ab50-7a297c69b132@proton.me> <ZuhTdwCqz61bQEgq@phenom.ffwll.local>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dab97672c13097b183b60e0cd06fd55dadb583ba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.09.24 17:49, Simona Vetter wrote:
> On Fri, Sep 13, 2024 at 04:49:29PM +0000, Benno Lossin wrote:
>> On 13.09.24 17:33, Simona Vetter wrote:
>>> On Fri, Sep 13, 2024 at 11:26:57AM +0000, Benno Lossin wrote:
>>>>  /// Used to transfer ownership to and from foreign (non-Rust) languag=
es.
>>>> @@ -532,3 +533,248 @@ unsafe impl AsBytes for str {}
>>>>  // does not have any uninitialized portions either.
>>>>  unsafe impl<T: AsBytes> AsBytes for [T] {}
>>>>  unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
>>>> +
>>>> +/// Untrusted data of type `T`.
>>>> +///
>>>> +/// When reading data from userspace, hardware or other external untr=
usted sources, the data must
>>>> +/// be validated before it is used for logic within the kernel. To do=
 so, the [`validate()`]
>>>> +/// function exists and uses the [`Validator`] trait. For raw bytes v=
alidation there also is the
>>>> +/// [`validate_bytes()`] function.
>>>> +///
>>>> +///
>>>> +/// [`validate()`]: Self::validate
>>>> +/// [`validate_bytes()`]: Self::validate_bytes
>>>> +#[repr(transparent)]
>>>> +pub struct Untrusted<T: ?Sized>(T);
>>>
>>> I think we could make this a bit more strict and instead of encouraging
>>> people to put all their validation code into a Validator<T>, force
>>> them to. Which means assuming apis wrap all untrusted stuff in
>>> Untrusted<T> reviewers only need to look at validate implementations an=
d
>>> nothing else.
>>>
>>> If I'm not too wrong with my rust I think this would work with slitting
>>> Untrusted<T> into two types:
>>>
>>> - Untrusted<T> is just a box you can't access, and the type returned by
>>>   apis for untrusted data. It doesn't have any of the functions except
>>>   validate and new_untrusted so that you can't get at the data at all.
>>>
>>> - UntrustedUnsafe<T> does have all the accessors needed for validation,
>>>   but you can't construct that outside of this module. Maybe simplest t=
o
>>>   just nest this within the Untrusted<T> box.
>>>
>>> - Untrusted::validate does the unboxing and passes a reference to
>>>   UntrustedUnsafe<T> to Validator::validate, to guarantee that all the
>>>   validation code is in there and nowhere else. Similar for
>>>   validate_bytes.
>>>
>>> Of course people can still bypass this easily, but it gets a bit harder=
 to
>>> do so, and easier for reviewers to verify everything.
>>
>> This is a great idea!
>> I think we should also remove `validate_bytes`, then you really must
>> implement `Validator`. If we figure out later that people need it, we
>> can add it later again. I added it because I thought that implementing
>> `Validator` for something very small might be very annoying, but it
>> seems like you actually want to force people to implement it :)
>=20
> See further down, I think there's a real use-case for validate_bytes, or
> something really close to it at least.

That's good to know, then I will keep it.

>> I think we should discuss the name `UntrustedUnsafe` though, I don't
>> really like the `Unsafe` although I understand why you used it. What do
>> you think of renaming the current `Untrusted` (and the one that only
>> exposes `validate`) to `Unvalidated` and using `Untrusted` as the
>> parameter for `Validator::validate`?
>=20
> Much better, I didn't like my naming either.

While designing my LPC slides, I think that we actually don't need two
types. We can just have `Untrusted` that exposes nothing except
`validate[_bytes]` and have the `Validator::validate` function take the
input data directly unwrapped. Thoughts?

>> Alternatively, we could use `Unverified`/`Untrusted`, because
>> unvalidated is not a "real English word". But then I think we also
>> should rename `Validator` to `Verifier` etc.
>>
>>>> +    /// Gives direct access to the underlying untrusted data.
>>>> +    ///
>>>> +    /// Be careful when accessing the data, as it is untrusted and st=
ill needs to be verified! To
>>>> +    /// do so use [`validate()`].
>>>> +    ///
>>>> +    /// [`validate()`]: Self::validate
>>>> +    pub fn untrusted(&self) -> &T {
>>>> +        &self.0
>>>> +    }
>>>> +
>>>> +    /// Gives direct access to the underlying untrusted data.
>>>> +    ///
>>>> +    /// Be careful when accessing the data, as it is untrusted and st=
ill needs to be verified! To
>>>> +    /// do so use [`validate()`].
>>>> +    ///
>>>> +    /// [`validate()`]: Self::validate
>>>> +    pub fn untrusted_mut(&mut self) -> &mut T {
>>>> +        &mut self.0
>>>> +    }
>>>> +
>>>> +    /// Unwraps the data and removes the untrusted marking.
>>>> +    ///
>>>> +    /// Be careful when accessing the data, as it is untrusted and st=
ill needs to be verified! To
>>>> +    /// do so use [`validate()`].
>>>> +    ///
>>>> +    /// [`validate()`]: Self::validate
>>>> +    pub fn into_inner_untrusted(self) -> T
>>>
>>> I don't like the above two since they could be easily and accidentally
>>> abused to leak untrusted data. And at least in your example I think
>>> they're fallout from being a bit too eager with annotating data as
>>> untrusted. The Folio and Mapped itself are just kernel structures, they
>>> better be correct. So I don't think it's useful to annotate those as
>>> untrusted and rely on Deref to also annotate the actual data as untrust=
ed,
>>> because it forces you to peak behind the box a few times.
>>
>> As I wrote in patch 2, I have no idea if I added the `Untrusted<T>` in
>> the correct places, as I don't know folios. I would disagree, that these
>> methods are necessary because of marking the entire folio as untrusted,
>> they are needed to access the data from within the `Validator::validate`
>> function, but with your above suggestion, we can move them to the
>> internal type.
>>
>>> Instead I think we only want to annotate the Folio Deref:
>>>
>>> impl<S> Deref for Mapped<'_, S> {
>>>     type Target =3D Untrusted<[u8]>;
>>>
>>> Now there will be folios that we trust because they're kernel internal
>>> data and not file cache, so we need more flexibility here. No idea how =
to
>>> best make that happen, but in either case it's only the Deref data itse=
lf
>>> we don't trust, not any of the structures around it. One example would =
be
>>> gpu page tables. One way to implement this would be to make the Target
>>> type a generic of the folio, or well an associated type of the existing
>>> generics folio paramater:
>>>
>>> pub struct Folio<S: FolioType>
>>>
>>> pub trait FolioType {
>>> =09type Data;
>>> }
>>>
>>> impl<T> FolioType for PageCache<T> {
>>> =09type Data =3D Untrusted<[u8]>;
>>> }
>>>
>>> And gpu pagetables would use a something like this instead:
>>>
>>> impl FolioType for GpuFolios {
>>> =09type Data =3D [struct GpuPTE];
>>> }
>>>
>>> All extremely untested.
>>
>> What I would like to avoid is having to do this for every possible data
>> source. Ideally we could just wrap trusted data sources with `Untrusted`
>> and be done with it.
>> If the wrapped type is not plain data, but rather a smart pointer or
>> other abstraction, then only the underlying data is marked untrusted
>> (otherwise how would you even know that the pointer can be used?). So
>> for example one might have an `Untrusted<ARef<[u8]>>`.
>=20
> Yeah I think for pure smart pointers this is great, hence why I didn't
> object to your Deref implementation. But if there's an entire
> datastructure around it (like with pagecache) I think we need to sprinkle
> associated types around to make this work.
>=20
> What imo breaks annotations like this is if you have a lot of false
> positive cases that force people to jump through hoops and normalize
> having random uncecessary "validate" code all over. That defeats the
> point.

Agreed.

>> What I think we should do instead is make our APIs that return untrusted
>> data just return `Untrusted<Folio>` and implement the following method:
>>
>>     impl Folio {
>>         pub fn read(self: &Untrusted<Self>) -> &Untrusted<[u8]>;
>>     }
>>
>> I think that is the best of both worlds: we don't need to do excessive
>> type shenanigans for every type carrying potentially untrusted data and
>> we get to have methods specific to untrusted data.
>>
>> However, I think implementing this method will be a bit difficult with
>> the `Untrusted`/`Unvalidated` split. Maybe we can have some `pub(crate)`
>> methods on `Unvalidated` to perform some mappings?
>=20
> The thing is, folios are just a pile of contig pages, and there's nothing
> in the rules that they only contain untrusted data. Currently in rust cod=
e
> we have that's the case, but not in general. So we need that associated
> type.
>=20
> But I also think Folio here is special, a lot of the other places where I
> want this annotation it's the case that the data returned is _always_
> untrusted. So we don't need to place associated types all over the
> codebase to make this work, it's just that the rfc example you've picked
> needs it.

I think we should try to make just wrapping stuff in `Untrusted` work. I
don't see how the associated types would help you any more than just
implementing stuff on `&Untrusted<Self`.

> E.g. copy_from_user is _always_ untrusted, not exception. Network packets
> we read are also always untrusted. When you have a device driver and want
> to be robust against evil implementations (external bus like usb or cloud
> virtual hw with confidential compute), then also everything you ever read
> from that device is always untrusted until validated.
>=20
> And the neat thing is if we get this right, there's a lot of cases where
> the Untrusted<> wrapper doesn't matter, because we just pass from one
> untrusted to another. E.g. for the write() syscall (or an implemenation o=
f
> that in an fs) we get a Untrusted<[u8]> from Folio and let copy_from_user
> directly write into that. But that only works if the annotations are
> exactly right, not too much, not too little.

Yeah this would be very nice, if you never need to look inside of the
untrusted data, then you can just move it along.

> Oh another one we need:
>=20
> impl<T: AsBytes> AsBytes for Untrusted<AsBytes>
>=20
> Otherwise you can't write untrusted stuff to userspace, which is really n=
o
> issue at all (e.g. networking, where the kernel only parses the headers
> and shovels the data to userspace unchecked).

Sure.

>>> Now I think there are cases you can't cover with just validate, where y=
ou
>>> have multiple input data which needs to be cross-checked to ensure over=
all
>>> validity. But I think that we can cover that by implementing a Validato=
r
>>> for tuples and making Untrusted a trait so that we can either Accept
>>> Untrusted<(A, B)> or (Untrusted<A>, Untrusted<B>) interchangably when
>>> calling validate().
>>
>> I could imagine us adding conversion functions that can combine
>> untrusted values. Additionally, we should probably add a `Context` type
>> to `Validator` that is an additional parameter.
>>
>>> At least with an hour of theorizing and your one example I couldn't com=
e
>>> up with anything else.
>>
>> Yeah, we need more users of this to know the full way to express this
>> correctly. I would like to avoid huge refactorings in the future.
>=20
> I think adding it to the copy_*_user functions we already have in
> upstream, and then asking Alice to rebase binder should be a really solid
> real-world testcase. And I think currently for the things in-flight
> copy*user is going to be the main source of untrusted data anyway, not so
> much page cache folios.

Sure. I chose tarfs as the use-case, because Greg mentioned to me that
it would benefit from adding this API. (I have no prior linux kernel
experience, so you giving me some pointers where this will be useful is
very helpful!)

>>>> +impl Untrusted<[u8]> {
>>>> +    /// Validate the given bytes directly.
>>>> +    ///
>>>> +    /// This is a convenience method to not have to implement the [`V=
alidator`] trait to be able to
>>>> +    /// just parse some bytes. If the bytes that you are validating h=
ave some structure and/or you
>>>> +    /// will parse it into a `struct` or other rust type, then it is =
very much recommended to use
>>>> +    /// the [`Validator`] trait and the [`validate()`] function inste=
ad.
>>>> +    ///
>>>> +    /// # Examples
>>>> +    ///
>>>> +    /// ```
>>>> +    /// # fn get_untrusted_data() -> &'static Untrusted<[u8]> { &[0; =
8] }
>>>> +    ///
>>>> +    /// let data: &Untrusted<[u8]> =3D get_untrusted_data();
>>>> +    /// let data: Result<&[u8], ()> =3D data.validate_bytes::<()>(|un=
trusted| {
>>>> +    ///     if untrusted.len() !=3D 2 {
>>>> +    ///         return Err(());
>>>> +    ///     }
>>>> +    ///     if untrusted[0] & 0xf0 !=3D 0 {
>>>> +    ///         return Err(());
>>>> +    ///     }
>>>> +    ///     if untrusted[1] >=3D 100 {
>>>> +    ///         return Err(());
>>>> +    ///     }
>>>> +    ///     Ok(())
>>>> +    /// });
>>>> +    /// match data {
>>>> +    ///     Ok(data) =3D> pr_info!("successfully validated the data: =
{data}"),
>>>> +    ///     Err(()) =3D> pr_info!("read faulty data from hardware!"),
>>>> +    /// }
>>>> +    /// ```
>>>> +    ///
>>>> +    /// [`validate()`]: Self::validate
>>>> +    pub fn validate_bytes<E>(
>>>
>>> I think this is a special case of a somewhat common in-place validation
>>> pattern. For example in in complex syscall or ioctl we need to copy
>>> structures from userspace anyway and doing yet another copy to put them
>>> into a rust structure isn't great, instead we validate in-place. So I
>>> think we need something like
>>>
>>> impl Untrusted<T> {
>>> =09pub fn validate_inplace<E>(
>>> =09=09&self,
>>> =09=09validator: impl FnOnce(&T) -> Result<(), E>,
>>> =09=09) -> Result <&T, E> {
>>> =09=09...
>>> =09}
>>> }
>>
>> I had thought about in-place validation as well, but I first wanted to
>> get a feel for how to do it, since I felt that in-place might make it
>> significantly more complicated.
>> In your proposal, you give a reference back, but maybe the data started
>> out as a `Box<[u8]>` (or how do you usually copy from userspace?), so it
>> would be better to be able to also handle owned data.
>=20
> The code in upstream is just MaybUninit<[u8]>.

Where is that stored though? On the heap or the stack?

>> Also, it might be a good idea to just make the copy to kernel and
>> validate a single step.
>=20
> Yeah that'd be a nice helper, but I think conceptually you want it to be
> two steps: Often for efficiency complex structures are linearized into on=
e
> single memory block, so that you can pull it all in with one
> copy_from_user. But validation would need to look at each piece (and it's
> often mixed, not just an array), probably together with Alice's Range
> datatype to make sure we're don't have index confusions.

Yeah that makes sense.

>>> Eventually we might want a _mut version of this too, because often uapi
>>> extensions means we need to correctly fill out default values for
>>> extensions when being called by old userspace, and that requires
>>> mutability. And it really is often an integral part of input validation=
.
>>
>> I see, will have to think about how to include this as well.
>>
>>> Also I think we might need an Iterator for Untrusted<I: IntoIterator> s=
o
>>> that we can validate Untrusted<[T]> and things like that with standard =
map
>>> and collect and do it all inplace.
>>
>> Hmm, so a general iterator for `Unvalidated` might be a bad idea, but
>> for the `Untrusted`, it should be fine.
>=20
> Yup that was my thinking too, the idea being that you write a validator
> for a single element, and then let Iterator magic handle things when you
> need to validate an entire array.
>=20
>>>> +pub trait Validator {
>>>> +    /// Type of the input data that is untrusted.
>>>> +    type Input: ?Sized;
>>>> +    /// Type of the validated data.
>>>> +    type Output;
>>>
>>> So I think the explicit Output makes sense if you have multiple differe=
nt
>>> untrusted input that validate to the same trusted structure, but I'm no=
t
>>> sure this makes sense as associated types. Instead I'd go with generics
>>> and somethign like this:
>>>
>>> pub trait Validator<Input: ?Sized> {
>>>     type Err;
>>>
>>>     fn validate(untrusted: &Untrusted<Input>) -> Result<Self, Self::Err=
>;
>>> }
>>>
>>> That means you can't implement validate for types from other modules
>>> directly but need a newtype (I think at least, not sure). But I think
>>> that's actually a good thing, since often that means you're validating
>>> some generic state plus whatever your own code needs (like the
>>> inode::Params<tarfs::INodeData> in your example), and both pieces need =
to
>>> be consisted overall and not just individually (otherwise why does the
>>> that other module not do the parsing for you). And so explicitly treati=
ng
>>> the validated output as an explicit new type just makes sense to me. Pl=
us
>>> with derive(Deref) it's trivial to unbox after validation.
>>
>> There might be the need to validate the same piece of data with
>> different ways and I am not convinced adding a newtype for every single
>> case is a good way to achieve it.
>> Although it would simplify the `Validator` trait... I will think a bit
>> about this.
>=20
> Hm, but unless I misunderstand you already need a random type to attach
> your current trait too? So not worse if we require that for the
> less-common type of multiple ways to validate the same, and simpler for
> the common one.

Yes, but you wouldn't have to unwrap the return type. For example with
your proposal we have:

    struct MyINodeParams(INodeParams);

    impl Validator<[u8]> for MyINodeParams {
        type Err =3D Error;

        fn validate(untrusted: &Untrusted<[u8]>) -> Result<Self> {
            /*...*/
            Ok(Self(params))
        }
    }

    impl MyINodeParams {
        fn into_inner(self) -> INodeParams {
            self.0
        }
    }

And then you would do:

    let params =3D untrusted.validate::<MyINodeParams>().into_inner();

I find the `into_inner()` a bit annoying (one could just use `.0`
instead, but I also don't like that). I find specifying the `Output` a
bit cleaner.
   =20
---
Cheers,
Benno

>>> Cheers, Sima
>>
>> Thanks a lot for taking a look!
>=20
> I _really_ want this :-)
> -Sima
> --
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch


