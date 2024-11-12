Return-Path: <linux-kernel+bounces-405975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F229C5980
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E771F21ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE851FBC90;
	Tue, 12 Nov 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7S1u65o"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5B1F7084
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419312; cv=none; b=lcAwicNzgZUdLMOergnbYbM+arLbcHGQL3tXllHu5NrV01DIOvyA5gINz9CvPjidfkX+EE9+FyLClTTPWCfuSjBTqoZcfSJ/O70asBwoqthG2u5L5FWTsWcri8w0svkxfUKheEgRi01AoE/qizHM3amsMEkJwcaMk0tssSkCrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419312; c=relaxed/simple;
	bh=eEK1VOirfwQDoERg/9cjCqNldd89/MubJ1yy544QOjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTneeJrTdGetxbBMfS+NWeCKQ82z+MhY1d1NgwHQyYwfamYpN7fYHFVsnAz8pHPR8nE6ohQDghIlfdBNxrCHOFOi9p59IX9ZycxbVvFYBK23DSyxqmWyuSWU5hgBvgUHBhhmrhVC26Fi7R8lPpG/kltE66lFI6AV4qPBDc5gxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w7S1u65o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431481433bdso50059065e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731419308; x=1732024108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0Bt3cTskBCk6o9ZlLMF5C89FTz+EridgzevBUz3T5I=;
        b=w7S1u65oLXP5xv4n+Eb61+eVHnsYLGm8iGowyiLnzsHc+QRDhUHR/hgLhaVpUnScQy
         Y4LsWe/gN/UPOqHcOo839v6CbKHo5WL/sT7Rn1qsDR8tGfgU1GbkMgON1Y6EWWiW3h86
         COYXvbMbzeZbiGe3IXYZ4emOCja3g0k8FxtZV01knRxZ1+bFsgoa3ubnGPG2dG7Yg8qJ
         AXuaMsYSP3DcV1zFUnDy9Eh6ugRDinDp2eH9//brZClaosliF7Hu15/PJNoyrcK2LOGM
         0JL3z7k7A56xB92B+DjxMmf9nYq9CoHykAcVtokZQwUK2BaQ8zZF/ZhtvvtT9lxh/n+z
         PPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419308; x=1732024108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0Bt3cTskBCk6o9ZlLMF5C89FTz+EridgzevBUz3T5I=;
        b=WI53Cz/GuQq2QhL9b6HdGxBKZGwefgqpUC4Ss4vEjvGMc4EzkqzoHY+cQJ5LCJ7v1x
         tSDd4osFnII3od2tD01qhY6kuZhTOixBfqw24Ybe+OsZRpGP+zmg77yvp5wjE2J6iCpa
         2/ruDgb8RjMwtYijdnwuT8naVzu6PBSm5DC6sU9b7GpolJf8Qum96l9yXKg+0qGmwT+2
         6WEpdA1UsP4O2jb+heLTCeUBMjopHzsA9ZvHZSU4r1Pp6cycYE7uTrM2I3BwIDsa5wXe
         72Rs0FwWw/2BjDCSjUEuGJpIt0MoySiqYrcOKH6s9mpUjnWEzNzdQFWOW9G0+7uLb3Na
         vvFg==
X-Forwarded-Encrypted: i=1; AJvYcCVsCwE3n321JO5BZK3BzQ1K1uBuNEV6x6tqAGtisTnpXfoLbXjPdXPmPRe6YE1EBchHqvSeXvahEgC7PA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQCGuEa3+zdcsF1DgB0y+6/H6KOiMMR/t50TRhfPOY2cbPoBa2
	ZPHAbDu9oghp9TsXR8niu00KkCefb/U5WNs1uuFJvbZ2ObR2z0w15HSH6TFVO9YJRsaTFLBO229
	NnQngV4297+ywTKi6n10dybntSn5MOUt0bZHm
X-Google-Smtp-Source: AGHT+IE1J+VmjcNvDxd3q8JHsSFcwTbP/VHp77L6+HUbWekK6NZOn+D+vAz97AhdCSmOBc2KFN5aHs2pskwzaJSU0b0=
X-Received: by 2002:a05:600c:4141:b0:432:c774:2e24 with SMTP id
 5b1f17b1804b1-432c7743022mr58929635e9.9.1731419308449; Tue, 12 Nov 2024
 05:48:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-vma-v6-0-d89039b6f573@google.com> <20241010-vma-v6-1-d89039b6f573@google.com>
 <CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zDkqSw@mail.gmail.com>
 <CAH5fLgjeWKSH+4X+moy9Qc9YOp0dKAFZic6wBHjq_D6NHFmNRg@mail.gmail.com>
 <CAG48ez2bdKj9=rHuu221jtLK9P_a9j-MVx=pW=zg91RPrBrZ_w@mail.gmail.com>
 <CAH5fLgiVTK6mv5m4FaNFZMP4vHKo=8UbR9qm56aaB0Dmrp3x3w@mail.gmail.com> <CAG48ez0S_dgXUM476vithROG3-su+-UcJGYs52fvSeg0LG1eWA@mail.gmail.com>
In-Reply-To: <CAG48ez0S_dgXUM476vithROG3-su+-UcJGYs52fvSeg0LG1eWA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 12 Nov 2024 14:48:16 +0100
Message-ID: <CAH5fLgiBgMTQ7Qe-Akwz+VBJu=0v_DpfzPMDbVD_N031dnSO4A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Jann Horn <jannh@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:58=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Nov 12, 2024 at 1:12=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > On Mon, Nov 11, 2024 at 5:51=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On Mon, Nov 11, 2024 at 12:41=E2=80=AFPM Alice Ryhl <aliceryhl@google=
.com> wrote:
> > > > Thanks a lot for your review!
> > > >
> > > > Note that there is a v7 already:
> > > > https://lore.kernel.org/all/20241014-vma-v7-0-01e32f861195@google.c=
om/
> > >
> > > Yeah, oops, somehow I only realized I was looking at an older version
> > > of the series after sending my mail...
> > >
> > > > On Fri, Nov 8, 2024 at 8:02=E2=80=AFPM Jann Horn <jannh@google.com>=
 wrote:
> > > > > On Thu, Oct 10, 2024 at 2:56=E2=80=AFPM Alice Ryhl <aliceryhl@goo=
gle.com> wrote:
> > > > >> These abstractions allow you to manipulate vmas. Rust Binder wil=
l uses
> > > > >> these in a few different ways.
> > > > >>
> > > > >> In the mmap implementation, a VmAreaNew will be provided to the =
mmap
> > > > >> call which allows it to modify the vma in ways that are only oka=
y during
> > > > >> initial setup. This is the case where the most methods are avail=
able.
> > > > >>
> > > > >> However, Rust Binder needs to insert and remove pages from the v=
ma as
> > > > >> time passes. When incoming messages arrive, pages may need to be
> > > > >> inserted if space is missing, and in this case that is done by u=
sing a
> > > > >> stashed ARef<Mm> and calling mmget_not_zero followed by mmap_wri=
te_lock
> > > > >> followed by vma_lookup followed by vm_insert_page. In this case,=
 since
> > > > >> mmap_write_lock is used, the VmAreaMut type will be in use.
> > > > >
> > > > > FYI, the way the C binder implementation uses vma_lookup() and
> > > > > vm_insert_page() is not very idiomatic. The standard way of
> > > > > implementing binder_alloc_free_page() would be to use something l=
ike
> > > > > unmap_mapping_range() instead of using
> > > > > vma_lookup()+zap_page_range_single(); though to set that up, you'=
d
> > > > > have to create one inode per binder file, maybe with something li=
ke
> > > > > the DRM subsystem's drm_fs_inode_new(). And instead of having
> > > > > binder_install_single_page(), the standard way would be to let
> > > > > binder_vm_fault() install PTEs lazily on fault. That way you'd ne=
ver
> > > > > have to take mmap locks or grab MM references yourself.
> > > >
> > > > Would that actually work? All writes happen from kernel space, so i=
t's
> > > > not clear to me that we can trigger the fault handler from there. W=
e
> > > > can't use copy_to_user because the write happens from a different
> > > > process than the one that owns the vma.
> > > >
> > > > That said, one alternative is to let Binder store an array of `stru=
ct
> > > > page` and just write directly to those pages when writing from kern=
el
> > > > space. Then binder_vm_fault() can look up the relevant page from th=
e
> > > > array when userspace attempts to read the data.
> > >
> > > Right, that's what I was thinking of - keep allocating pages at the
> > > same point in time when binder currently does it, only defer mapping
> > > them into userspace.
> > >
> > > > Though we could also
> > > > just vm_insert_page() right before returning the address to userspa=
ce,
> > > > since we know that userspace will read it right away after the sysc=
all
> > > > returns.
> > >
> > > I think that is basically what binder does now?
> >
> > Right now binder calls vm_insert_page() right after calling
> > alloc_page(), which means that vm_insert_page() happens in the process
> > sending the message. But we could delay the call so that it happens in
> > the process that receives the message instead (which is also the
> > process that owns the mapping).
>
> Ah, I see. I don't think that would make much of a difference in terms
> of the complexity of MM locking, except that you'd save an
> mmget_not_zero()...

It might reduce contention on the mm locks since it drastically
reduces the number of threads we might take the locks from.

Another question ... right now we access the vma by doing vma_lookup
under the mmap lock, and then we call vm_insert_page. The call to
vm_insert_page only requires the vma read lock, so it would be nice to
perform vm_insert_page without having to take the mmap lock to do
vma_lookup. What is the best way to do that? I could stash a pointer
to the vma, but I need to make sure it doesn't get freed in the
meantime. I could keep track of whether it's still valid by listening
for close in vma_ops, but that's a pretty unpleasant solution. I don't
see any refcount in `struct vm_area_struct` that I can increment.

> > > > > Let me know if you think it would be helpful to see a prototype o=
f
> > > > > that in C - I think I can cobble that together, but doing it nice=
ly
> > > > > will require some work to convert at least some of the binder_all=
oc
> > > > > locking to mutexes, and some more work to switch the ->f_mapping =
of
> > > > > the binder file or something like that. (I guess modeling that in=
 Rust
> > > > > might be a bit of a pain though...)
> > > >
> > > > It would be useful to hear about what the advantages of
> > > > unmap_mapping_range() are. I don't need a full prototype, I should =
be
> > > > able to understand given a rough description of what the required
> > > > changes are.
> > >
> > > The nice part is that basically, if you have a pointer to the file or
> > > the inode, you can just do something like the following to zap a PTE:
> > >
> > > unmap_mapping_range(file->f_mapping, index, 1, 1);
> > >
> > > You don't have to take any locks yourself to make that work, you don'=
t
> > > even have to hold a reference to the mm_struct or anything like that,
> > > and you don't need any of that logic you currently have in the C
> > > binder driver to look up the VMA by address and revalidate it is stil=
l
> > > the VMA you expect. The MM subsystem will automatically iterate
> > > through all VMAs that overlap the specified range of the file's
> > > address_space, and it will zap PTEs in the specified range (and it
> > > even works fine if the VMAs have been moved or split or exist in
> > > multiple processes or stuff like that). It's a similar story on the
> > > allocation path. The only locks you need to explicitly take are
> > > whatever locks the driver internally requires.
> > >
> > > Going through the fault handler and/or the address_space for
> > > installing/removing PTEs, instead of using vma_lookup(), is also safe=
r
> > > because it implicitly ensures you can only operate on your own
> > > driver's VMAs. From a glance at the Rust binder RFC
> > > (https://lore.kernel.org/all/20231101-rust-binder-v1-19-08ba9197f637@=
google.com/),
> > > it looks like use_page_slow() just looks up the VMA at the expected
> > > address and calls insert_page() on it. I don't immediately see
> > > anything in the Rust Binder RFC that would prevent calling
> > > insert_page() on a newly created VMA of a different type that has
> > > appeared at the same address - which could cause the page to
> > > inadvertently become writable by userspace (if the new VMA is
> > > writable), could cause refcounted pages to be installed in VM_PFNMAP
> > > regions that are supposed to only contain non-refcounted entries,
> > > could probably cause type confusion when trying to install 4K pages i=
n
> > > hugetlb regions that can't contain 4K pages, and so on.
> >
> > Right ... I guess I'm missing an equivalent to binder_vma_close to
> > ensure that once the vma is closed, we don't try to insert pages.
>
> Yeah, I think that would work. (I think there currently is no way to
> shrink a VMA without first splitting it, so you should see ->open()
> and ->close() invocations when that happens.)
>
> > I gave a suggestion to enforce that vm_insert_page is only called on
> > MIXEDMAP vmas in my previous email. I guess that would prevent the
> > type confusion you mention, but it still seems dangerous ... you risk
> > that some other driver is storing special data in the private data of
> > pages in the new vma, and if you insert a random page there, there
> > could maybe be type confusion on the private data in the `struct
> > page`?
>
> Hmm, yeah, maybe...

Is there a standard / idiomatic way for a driver to verify that a VMA
is the one that it created? Checking vm_ops and private data?

> > > > >> +    /// Maps a single page at the given address within the virt=
ual memory area.
> > > > >> +    ///
> > > > >> +    /// This operation does not take ownership of the page.
> > > > >> +    #[inline]
> > > > >> +    pub fn vm_insert_page(&self, address: usize, page: &Page) -=
> Result {
> > > > >> +        // SAFETY: By the type invariants, the caller holds the=
 mmap write lock, so this access is
> > > > >> +        // not a data race. The page is guaranteed to be valid =
and of order 0. The range of
> > > > >> +        // `address` is already checked by `vm_insert_page`.
> > > > >> +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr=
(), address as _, page.as_ptr()) })
> > > > >
> > > > > vm_insert_page() has a kinda weird contract because there are two
> > > > > contexts from which you can call it cleanly:
> > > > >
> > > > > 1. You can call it on a VmAreaRef (just like zap_page_range_singl=
e(),
> > > > > you only need to hold an mmap read lock or VMA read lock, no writ=
e
> > > > > lock is required); however, you must ensure that the VMA is alrea=
dy
> > > > > marked VM_MIXEDMAP. This is the API contract under which you'd ca=
ll
> > > > > this from a fault handler.
> > > > >
> > > > > 2. You can call it on a VmAreaNew (and it will take care of setti=
ng
> > > > > VM_MIXEDMAP for you).
> > > > >
> > > > > I think nothing would immediately crash if you called vm_insert_p=
age()
> > > > > on a VMA that does not yet have VM_MIXEDMAP while holding the mma=
p
> > > > > lock in write mode; but that would permit weird scenarios where y=
ou
> > > > > could, for example, have a userfaultfd context associated with a =
VMA
> > > > > which becomes VM_MIXEDMAP, while normally you can't attach userfa=
ultfd
> > > > > contexts to VM_MIXEDMAP VMAs. I don't think if that actually lead=
s to
> > > > > anything bad, but it would be a weird state that probably shouldn=
't be
> > > > > permitted.
> > > > >
> > > > > There are also safety requirements for the page being installed, =
but I
> > > > > guess the checks that vm_insert_page() already does via
> > > > > validate_page_before_insert() might be enough to make this safe..=
.
> > > >
> > > > One way to handle this is to make an VmAreaRef::check_mixedmap that
> > > > returns a VmAreaMixedMapRef after checking the flag. That type can =
then
> > > > have a vm_insert_page method.
> > >
> > > Sounds reasonable.
> > >
> > > > As for VmAreaNew, I'm not sure we should have it there. If we're no=
t
> > > > careful, it would be a way to set VM_MIXEDMAP on something that alr=
eady
> > > > has the VM_PFNMAP flag. We can probably just tell you to set VM_MIX=
EDMAP
> > > > directly and then go through the method on VmAreaRef.
> > >
> > > Makes sense.
> > >
> > > I guess one tricky part is that it might be bad if you could
> >
> > Seems like this sentence is incomplete?
>
> Whoops, guess I got distracted while writing this...
>
> I guess it could be bad if you could install page mappings before
> changing the VMA flags in a way that makes the already-installed page
> mappings invalid. But as long as you don't change the
> VM_READ/VM_WRITE/VM_EXEC flags, and you never clear
> VM_MIXEDMAP/VM_PFNMAP, I think that probably can't happen, so that
> should be fine...

Could we come up with a list of what the mm subsystem assumes about a
vma? Similar to Lorenzo's VMA locks documentation work. So far I have:

* If a vma is VM_MIXEDMAP then it doesn't have a userfaultfd context
and it is not VM_PFNMAP.
* If a vma is VM_PFNMAP then there are a bunch of restrictions on what
kind of pages you can insert.
* If VM_WRITE is set, then VM_MAYWRITE is also set. (And similarly for
the other perms.)

I'm sure there are many more.

Alice

