Return-Path: <linux-kernel+bounces-406489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51439C5FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED6F1F27740
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE021502E;
	Tue, 12 Nov 2024 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8Y9q7lm"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAFA215027
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434847; cv=none; b=fb8tB00hZ5UGKCtXkHKlr/GF2uQVEkFGrovUgt/BNLq3RIWEunvM6KJ/iPv8G3smxRfqesDCj926nVt22ttmzKbRGa5VkZwBNJceb46XzklZuqdnT7Rhu4/g6t26vCOZckvopwHF/nVvC3BIeOBxYLFG1auHbQSB2TC0M5EgUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434847; c=relaxed/simple;
	bh=sGGqmVTR7s1ciLuNx1kCbUqgKryLxgsMtv4hIVvIb/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2752i8XpkavX3wgaiZzeRUsyLdh6H5QjDON2K8YsiS77iBU+s98Y5IHYky4Y7A1Q4d2jP3qJ8cnamd/eabr3ZYmr00/j3uZZPMovoE6f0jSWWI4xpG5Fl0UqVb3uhtpcwe6iQEemEC1CPjUsV7PZ05RH4VlKEzhbCPKMu62rtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8Y9q7lm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so803a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731434844; x=1732039644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0AkWY2WyNlZIGipZznV26NS3K1jlvxNi3LIR9gDLWE=;
        b=n8Y9q7lm41lWgp7stSSUV72Mp8ifDOdC5PexZMGkvFG+Zzx7jbt0c+ENucttb7/2XH
         ulFo76fd5RfMhsCYltp6COmRkouMWOzfbbZYOJjBjf+NzTRkxUFk+ngaWiOItB2VYWFP
         44Nbbjb3FVUDNGE4L35qLLMUAV0ZuHhG9ROVFUAJkBSKE2QoJX3cfSsFrUBV/Z5jlfn8
         AIga+Fm0BEXOuuHsFK0dtuofS1wsVTFDzJy1kpdkBoSv482PlsUX6+03DURW2j57soQ6
         0h7bxfayl8B/c0c5cauWTk2n4imF4RB0mfBHgimfc4Lx99zPkT25KUzIcl/Zgip0qKYe
         zCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434844; x=1732039644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0AkWY2WyNlZIGipZznV26NS3K1jlvxNi3LIR9gDLWE=;
        b=RpR2ZFV2z+itabw0vCKbKN8dcX+1RCg6jt0OIietTCqKI3dmYlwWcyK4xN/kiRcFgm
         mmCHTnsfa0nfzY0dMrqk+dC3zaMzKyyDZ2qrbZAsMAJwBbN9WqnHY54xLtFWaMj8rj+e
         71Nll8bM4UjK0Y574ccgrKDBoahRNOhaNryXdd5q1B4iuJLScMZ9byEujiv13rDlWgFd
         Wit4rj2Xl21xDzvMrEWcRybQMUUpCefNrXQtwSV5nm0wrbwYI0gIidXeIR0woiezuu8d
         Onjq7y2rUt6mDRICfrQA/7Ilhqiv5uSiZ/sd1nAGoVQhrgrw1jAouR/ljEI0/twS3WM6
         l2eg==
X-Forwarded-Encrypted: i=1; AJvYcCXp6ZXSGALoIEE7/2GOwKHu3v08gWr89Nl9vxaLYTjkEghCrV31aTBtaqX1tQzPseZlGmVIx0nPKdlkc0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPzZ5bczny9hm+BZzZdujPaAAv2WnQLch2cXGWQbd57qyyANll
	ql2ac+KUnWEOZI+yBCtmVTJ9Az6uB5J8LsLMg2UZkOeoaLG++Z/maQVng1SLfNXrv0PKJCYv3lQ
	pQYbLbbTVf1rtwknJmbPaXYda9aC4TWyLVl65
X-Gm-Gg: ASbGnctq3UAr+PzmLii6tuG/dUdu83dWIixXktLrc4R97I58IqUgyuwNA4BDqlluojE
	8rwbPTLhJc9ucv+v/5QlxVbhffpGyKrJYqjUwecHVaD5EjMxKO07p6sNGog==
X-Google-Smtp-Source: AGHT+IGBrT6EnPdKJvKQOIYl/k8/SMjTrSjsxP5XhXt7Adu1j/1gDqaaU9LaXh5JA1hgT4y6e5lUnrq/elJZ3KqTUHU=
X-Received: by 2002:a05:6402:31a4:b0:5cb:666d:dc59 with SMTP id
 4fb4d7f45d1cf-5cf4f0c7286mr322310a12.4.1731434843061; Tue, 12 Nov 2024
 10:07:23 -0800 (PST)
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
 <CAH5fLgiVTK6mv5m4FaNFZMP4vHKo=8UbR9qm56aaB0Dmrp3x3w@mail.gmail.com>
 <CAG48ez0S_dgXUM476vithROG3-su+-UcJGYs52fvSeg0LG1eWA@mail.gmail.com> <CAH5fLgiBgMTQ7Qe-Akwz+VBJu=0v_DpfzPMDbVD_N031dnSO4A@mail.gmail.com>
In-Reply-To: <CAH5fLgiBgMTQ7Qe-Akwz+VBJu=0v_DpfzPMDbVD_N031dnSO4A@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 12 Nov 2024 19:06:47 +0100
Message-ID: <CAG48ez32zWt4mcfA+y2FnzzNmFe-0ns9XQgp=QYeFpRsdiCAnw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Alice Ryhl <aliceryhl@google.com>
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

On Tue, Nov 12, 2024 at 2:48=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Tue, Nov 12, 2024 at 1:58=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Tue, Nov 12, 2024 at 1:12=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > > On Mon, Nov 11, 2024 at 5:51=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> > > >
> > > > On Mon, Nov 11, 2024 at 12:41=E2=80=AFPM Alice Ryhl <aliceryhl@goog=
le.com> wrote:
> > > > > Thanks a lot for your review!
> > > > >
> > > > > Note that there is a v7 already:
> > > > > https://lore.kernel.org/all/20241014-vma-v7-0-01e32f861195@google=
.com/
> > > >
> > > > Yeah, oops, somehow I only realized I was looking at an older versi=
on
> > > > of the series after sending my mail...
> > > >
> > > > > On Fri, Nov 8, 2024 at 8:02=E2=80=AFPM Jann Horn <jannh@google.co=
m> wrote:
> > > > > > On Thu, Oct 10, 2024 at 2:56=E2=80=AFPM Alice Ryhl <aliceryhl@g=
oogle.com> wrote:
> > > > > >> These abstractions allow you to manipulate vmas. Rust Binder w=
ill uses
> > > > > >> these in a few different ways.
> > > > > >>
> > > > > >> In the mmap implementation, a VmAreaNew will be provided to th=
e mmap
> > > > > >> call which allows it to modify the vma in ways that are only o=
kay during
> > > > > >> initial setup. This is the case where the most methods are ava=
ilable.
> > > > > >>
> > > > > >> However, Rust Binder needs to insert and remove pages from the=
 vma as
> > > > > >> time passes. When incoming messages arrive, pages may need to =
be
> > > > > >> inserted if space is missing, and in this case that is done by=
 using a
> > > > > >> stashed ARef<Mm> and calling mmget_not_zero followed by mmap_w=
rite_lock
> > > > > >> followed by vma_lookup followed by vm_insert_page. In this cas=
e, since
> > > > > >> mmap_write_lock is used, the VmAreaMut type will be in use.
> > > > > >
> > > > > > FYI, the way the C binder implementation uses vma_lookup() and
> > > > > > vm_insert_page() is not very idiomatic. The standard way of
> > > > > > implementing binder_alloc_free_page() would be to use something=
 like
> > > > > > unmap_mapping_range() instead of using
> > > > > > vma_lookup()+zap_page_range_single(); though to set that up, yo=
u'd
> > > > > > have to create one inode per binder file, maybe with something =
like
> > > > > > the DRM subsystem's drm_fs_inode_new(). And instead of having
> > > > > > binder_install_single_page(), the standard way would be to let
> > > > > > binder_vm_fault() install PTEs lazily on fault. That way you'd =
never
> > > > > > have to take mmap locks or grab MM references yourself.
> > > > >
> > > > > Would that actually work? All writes happen from kernel space, so=
 it's
> > > > > not clear to me that we can trigger the fault handler from there.=
 We
> > > > > can't use copy_to_user because the write happens from a different
> > > > > process than the one that owns the vma.
> > > > >
> > > > > That said, one alternative is to let Binder store an array of `st=
ruct
> > > > > page` and just write directly to those pages when writing from ke=
rnel
> > > > > space. Then binder_vm_fault() can look up the relevant page from =
the
> > > > > array when userspace attempts to read the data.
> > > >
> > > > Right, that's what I was thinking of - keep allocating pages at the
> > > > same point in time when binder currently does it, only defer mappin=
g
> > > > them into userspace.
> > > >
> > > > > Though we could also
> > > > > just vm_insert_page() right before returning the address to users=
pace,
> > > > > since we know that userspace will read it right away after the sy=
scall
> > > > > returns.
> > > >
> > > > I think that is basically what binder does now?
> > >
> > > Right now binder calls vm_insert_page() right after calling
> > > alloc_page(), which means that vm_insert_page() happens in the proces=
s
> > > sending the message. But we could delay the call so that it happens i=
n
> > > the process that receives the message instead (which is also the
> > > process that owns the mapping).
> >
> > Ah, I see. I don't think that would make much of a difference in terms
> > of the complexity of MM locking, except that you'd save an
> > mmget_not_zero()...
>
> It might reduce contention on the mm locks since it drastically
> reduces the number of threads we might take the locks from.
>
> Another question ... right now we access the vma by doing vma_lookup
> under the mmap lock, and then we call vm_insert_page. The call to
> vm_insert_page only requires the vma read lock, so it would be nice to
> perform vm_insert_page without having to take the mmap lock to do
> vma_lookup. What is the best way to do that? I could stash a pointer
> to the vma, but I need to make sure it doesn't get freed in the
> meantime. I could keep track of whether it's still valid by listening
> for close in vma_ops, but that's a pretty unpleasant solution. I don't
> see any refcount in `struct vm_area_struct` that I can increment.

You're not supposed to hold a long-term reference to a vm_area_struct.
Listening to ->close() would be error-prone because ->close() is
called later than when calling vm_insert_page() is no longer allowed.
The most lightweight locking you can use for looking up a VMA when you
go through the mm_struct is to call lock_vma_under_rcu(mm, address);
but that is a "trylock"-style operation, so if there is contention, it
will fail and in that case you have to instead take the mmap lock
normally. In userfaultfd code they have uffd_lock_vma() as a wrapper
that basically does a lock_vma_under_rcu() without trylock semantics
by temporarily taking the mmap lock (and it also ensures that the VMA
has an anon_vma if necessary), but there is currently no helper for
this that is available to the rest of the kernel.

(The exception to not being able to hold long-term references to a
vm_area_struct is the MM-internal rmap / address_space tracking: VMAs
that map a given file are tracked on an rbtree owned by that file's
address_space. That's how the MM code internally finds the VMAs when
you do something like unmap_mapping_range(). But you can't use that to
install new PTEs - well, it would probably be possible, but it would
require extra checks to protect against races.)

> > > > > > Let me know if you think it would be helpful to see a prototype=
 of
> > > > > > that in C - I think I can cobble that together, but doing it ni=
cely
> > > > > > will require some work to convert at least some of the binder_a=
lloc
> > > > > > locking to mutexes, and some more work to switch the ->f_mappin=
g of
> > > > > > the binder file or something like that. (I guess modeling that =
in Rust
> > > > > > might be a bit of a pain though...)
> > > > >
> > > > > It would be useful to hear about what the advantages of
> > > > > unmap_mapping_range() are. I don't need a full prototype, I shoul=
d be
> > > > > able to understand given a rough description of what the required
> > > > > changes are.
> > > >
> > > > The nice part is that basically, if you have a pointer to the file =
or
> > > > the inode, you can just do something like the following to zap a PT=
E:
> > > >
> > > > unmap_mapping_range(file->f_mapping, index, 1, 1);
> > > >
> > > > You don't have to take any locks yourself to make that work, you do=
n't
> > > > even have to hold a reference to the mm_struct or anything like tha=
t,
> > > > and you don't need any of that logic you currently have in the C
> > > > binder driver to look up the VMA by address and revalidate it is st=
ill
> > > > the VMA you expect. The MM subsystem will automatically iterate
> > > > through all VMAs that overlap the specified range of the file's
> > > > address_space, and it will zap PTEs in the specified range (and it
> > > > even works fine if the VMAs have been moved or split or exist in
> > > > multiple processes or stuff like that). It's a similar story on the
> > > > allocation path. The only locks you need to explicitly take are
> > > > whatever locks the driver internally requires.
> > > >
> > > > Going through the fault handler and/or the address_space for
> > > > installing/removing PTEs, instead of using vma_lookup(), is also sa=
fer
> > > > because it implicitly ensures you can only operate on your own
> > > > driver's VMAs. From a glance at the Rust binder RFC
> > > > (https://lore.kernel.org/all/20231101-rust-binder-v1-19-08ba9197f63=
7@google.com/),
> > > > it looks like use_page_slow() just looks up the VMA at the expected
> > > > address and calls insert_page() on it. I don't immediately see
> > > > anything in the Rust Binder RFC that would prevent calling
> > > > insert_page() on a newly created VMA of a different type that has
> > > > appeared at the same address - which could cause the page to
> > > > inadvertently become writable by userspace (if the new VMA is
> > > > writable), could cause refcounted pages to be installed in VM_PFNMA=
P
> > > > regions that are supposed to only contain non-refcounted entries,
> > > > could probably cause type confusion when trying to install 4K pages=
 in
> > > > hugetlb regions that can't contain 4K pages, and so on.
> > >
> > > Right ... I guess I'm missing an equivalent to binder_vma_close to
> > > ensure that once the vma is closed, we don't try to insert pages.
> >
> > Yeah, I think that would work. (I think there currently is no way to
> > shrink a VMA without first splitting it, so you should see ->open()
> > and ->close() invocations when that happens.)
> >
> > > I gave a suggestion to enforce that vm_insert_page is only called on
> > > MIXEDMAP vmas in my previous email. I guess that would prevent the
> > > type confusion you mention, but it still seems dangerous ... you risk
> > > that some other driver is storing special data in the private data of
> > > pages in the new vma, and if you insert a random page there, there
> > > could maybe be type confusion on the private data in the `struct
> > > page`?
> >
> > Hmm, yeah, maybe...
>
> Is there a standard / idiomatic way for a driver to verify that a VMA
> is the one that it created? Checking vm_ops and private data?

I think drivers normally don't look up their own VMAs by address, but
yeah, checking ->vm_ops would work for making sure the VMA comes from
your driver. It looks like the TCP zerocopy receive path does that in
find_tcp_vma().

> > > > > >> +    /// Maps a single page at the given address within the vi=
rtual memory area.
> > > > > >> +    ///
> > > > > >> +    /// This operation does not take ownership of the page.
> > > > > >> +    #[inline]
> > > > > >> +    pub fn vm_insert_page(&self, address: usize, page: &Page)=
 -> Result {
> > > > > >> +        // SAFETY: By the type invariants, the caller holds t=
he mmap write lock, so this access is
> > > > > >> +        // not a data race. The page is guaranteed to be vali=
d and of order 0. The range of
> > > > > >> +        // `address` is already checked by `vm_insert_page`.
> > > > > >> +        to_result(unsafe { bindings::vm_insert_page(self.as_p=
tr(), address as _, page.as_ptr()) })
> > > > > >
> > > > > > vm_insert_page() has a kinda weird contract because there are t=
wo
> > > > > > contexts from which you can call it cleanly:
> > > > > >
> > > > > > 1. You can call it on a VmAreaRef (just like zap_page_range_sin=
gle(),
> > > > > > you only need to hold an mmap read lock or VMA read lock, no wr=
ite
> > > > > > lock is required); however, you must ensure that the VMA is alr=
eady
> > > > > > marked VM_MIXEDMAP. This is the API contract under which you'd =
call
> > > > > > this from a fault handler.
> > > > > >
> > > > > > 2. You can call it on a VmAreaNew (and it will take care of set=
ting
> > > > > > VM_MIXEDMAP for you).
> > > > > >
> > > > > > I think nothing would immediately crash if you called vm_insert=
_page()
> > > > > > on a VMA that does not yet have VM_MIXEDMAP while holding the m=
map
> > > > > > lock in write mode; but that would permit weird scenarios where=
 you
> > > > > > could, for example, have a userfaultfd context associated with =
a VMA
> > > > > > which becomes VM_MIXEDMAP, while normally you can't attach user=
faultfd
> > > > > > contexts to VM_MIXEDMAP VMAs. I don't think if that actually le=
ads to
> > > > > > anything bad, but it would be a weird state that probably shoul=
dn't be
> > > > > > permitted.
> > > > > >
> > > > > > There are also safety requirements for the page being installed=
, but I
> > > > > > guess the checks that vm_insert_page() already does via
> > > > > > validate_page_before_insert() might be enough to make this safe=
...
> > > > >
> > > > > One way to handle this is to make an VmAreaRef::check_mixedmap th=
at
> > > > > returns a VmAreaMixedMapRef after checking the flag. That type ca=
n then
> > > > > have a vm_insert_page method.
> > > >
> > > > Sounds reasonable.
> > > >
> > > > > As for VmAreaNew, I'm not sure we should have it there. If we're =
not
> > > > > careful, it would be a way to set VM_MIXEDMAP on something that a=
lready
> > > > > has the VM_PFNMAP flag. We can probably just tell you to set VM_M=
IXEDMAP
> > > > > directly and then go through the method on VmAreaRef.
> > > >
> > > > Makes sense.
> > > >
> > > > I guess one tricky part is that it might be bad if you could
> > >
> > > Seems like this sentence is incomplete?
> >
> > Whoops, guess I got distracted while writing this...
> >
> > I guess it could be bad if you could install page mappings before
> > changing the VMA flags in a way that makes the already-installed page
> > mappings invalid. But as long as you don't change the
> > VM_READ/VM_WRITE/VM_EXEC flags, and you never clear
> > VM_MIXEDMAP/VM_PFNMAP, I think that probably can't happen, so that
> > should be fine...
>
> Could we come up with a list of what the mm subsystem assumes about a
> vma? Similar to Lorenzo's VMA locks documentation work. So far I have:
>
> * If a vma is VM_MIXEDMAP then it doesn't have a userfaultfd context
> and it is not VM_PFNMAP.

The "then it doesn't have a userfaultfd context" part is probably more
easily described as something like "VM_MIXEDMAP is not changed on a
VMA that is already in use".

> * If a vma is VM_PFNMAP then there are a bunch of restrictions on what
> kind of pages you can insert.

It's kind of the other way around. Normally, VMAs just contain
anonymous pages and file pages, which are fairly closely managed by
the MM core - they can be found through the "reverse mapping" and can
therefore usually be migrated/swapped/reclaimed, and they are
refcounted by the MM core. I am a bit fuzzy on VM_MIXEDMAP, but I
think it grants the ability to install a wider variety of pages that a
driver allocated itself (which are still refcounted but not tracked
through the reverse mapping), and also the ability to create PFN
mappings of physical addresses that are in physical address ranges not
managed by the MM subsystem (and therefore can't be refcounted).
Finally, VM_PFNMAP means "this is a super special memory range in
which the MM subsystem will just see opaque physical address mappings,
and any lifetime management of that physical memory is up to the
driver".

In other words, with VM_PFNMAP you can map basically any memory you
want - you can even map things like slab memory, or freed pages, and
the MM subsystem will be blind to that and basically won't care.
That's how /dev/mem can AFAIU let you mmap almost-arbitrary physical
memory when you disable CONFIG_STRICT_DEVMEM. But that also means
VM_PFNMAP is a great way to introduce physical memory use-after-free
bugs, because there is nothing that stops a buggy driver from freeing
pages that are still mmap'ed to userspace.

One feature of VM_PFNMAP VMAs that is desirable in some contexts is
that they stop get_user_pages_fast() from working. When you install a
normal page table entry with something like vm_insert_page(), that
AFAIK doesn't mark the PTE with pte_mkspecial(), and so userspace can
cause the kernel to grab a refcounted reference to the page and then
use this reference to read/write into the page at a later point, even
after it is no longer mapped into the page tables, and even after the
VMA is gone. (For example, by using vmsplice() to insert a reference
to the page into a pipe.) My understanding from a conversation with
upstream GPU developers is that they use VM_PFNMAP for this reason -
they want to be able to reliably revoke userspace access to pages when
they're unmapped. (We could probably improve that by having some way
for a driver to say "I want VM_MIXEDMAP but please don't let userspace
hold extra references to my pages"...)

In the context of binder, AFAIK because it does not use VM_PFNMAP,
userspace can still read the contents of binder pages after the
zap_page_range_single() call in binder_alloc_free_page(); but that's
fine because binder doesn't reuse the page afterwards. The subsequent
__free_page() call does not actually free the page - when it is called
on an order-0 page, it just drops the refcount on the page by 1, and
the page will be freed later on when no references to it are left.
Using put_page() might be a bit clearer there than using
__free_pages(), I guess? But I'm not entirely sure what the
nicest-looking APIs are for allocating/freeing order-0 pages with
refcounted semantics.

> * If VM_WRITE is set, then VM_MAYWRITE is also set. (And similarly for
> the other perms.)
>
> I'm sure there are many more.

I guess we could try to come up with a document with subjects like
"how drivers are supposed to interact with VMAs" and "other things
that a driver can do with VMAs (weird but okay)"...

