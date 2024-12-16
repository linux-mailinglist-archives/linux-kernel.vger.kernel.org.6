Return-Path: <linux-kernel+bounces-448314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD29F3E63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0A8167C95
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01EF1DAC92;
	Mon, 16 Dec 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPIDmf2N"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6001D63D1;
	Mon, 16 Dec 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392446; cv=none; b=LgXquXjlQy64b+OFIOkbepCYAIxGIdtJweCTqo0y2p2uxZ2NUaOsuyPwn6GGd4THQGLDyYnTQ+QQiNO2gUTnifTCMF5bku5IWtyirSNR5sB/LhPDdfN19ft59MaIgtx/MdFqzL56lSKXUNqcgOEH75ljTQLGVN70fqA25y0tzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392446; c=relaxed/simple;
	bh=GCJuqt5nR/50AeJWX2PlM06JQC2U8F3ibOOJg7k9F60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp6CUR151NDJC0a224ZelsqH82JlvucOBJf+tjpgMYMShGcAz+KYkNUB/rsFfdCjDINHGfe53yoN7Rnbvn3OtSv8GsEhIB7xUOQYhFOBCp+84OHDvutUXsFQk2hAzWLVJ+K6PB9FndQMgKxn7plBJp5LKJNnwzmxcljuSb1q1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPIDmf2N; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46783d44db0so48664791cf.1;
        Mon, 16 Dec 2024 15:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734392443; x=1734997243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V08DEnZfpKxBekBIJyGIOyXsH+kw7fY8zsFNeDXVqE=;
        b=VPIDmf2NqGhpuyalHARHby/agCeruERB2tb812b+R0AOaPOhK93Bq66I1Oq4x979df
         u/1JhdaHjdUYornzAHMc2+c9mphg02RUpCARDg8iCUkpJJ3V5lyYQR598VpYsDdjvzgG
         omaJROwP06zaVCn//zhMu+kC7Zr62futpJavD4IlwsG6r/Hona22skld11zwjIUvLpk7
         uUIXfv1zkLgOUaRs41gFPjzNp0aa+pBWeuOOGvG2CgU+MbB5eTiECglxUlpuYycEO4hG
         3+pLD6cHPdpgz6zIzCMAq/UIoHPkgF0Mmwex7+Ei7DkrCaULc62qb3uQ0ROjioYMQM8c
         Aacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734392443; x=1734997243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V08DEnZfpKxBekBIJyGIOyXsH+kw7fY8zsFNeDXVqE=;
        b=Bbv6kNp0NMYrSSkCQJsbt2L7ol6DuxMUrEoe4/sxB1tslsJSS6cATwltNLOEtnYmHn
         IKjRgV/4cLKa5mxhz71XTwC5t9lP1Zkikstq/Dx32cJE+cMXfBa/ULNWSUNBG+n02MTx
         tezA5djljVj/71xvMDc4v/1XzvMAB4n6fT24qrTieUq7G3j0RMadQMziJb3QK9Z8/J7i
         MSptBUg5FRa/9iKGq5wfgVKB59bBMzkOp05qrybS7HADJTC9eWuXBXtwYlHhCz1cwuqm
         0L+lI4UGUdy9VWgUeLnCC+d5ved59oBw2GDj/NI3uFDkO72Ka4TO8BFmwNPzGrYk4Spj
         TpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiLKIHxSGCZKPGGiB1vOZTvoMRJMlU9CSVBs00zFAUTaYQt/kIgAOIU+tSWTNH2pA9veBJkhia0ncN/bcHs0A=@vger.kernel.org, AJvYcCVBtkPJ/ymh6Is3oUvTWF2izsZf8D9X3FOZxZ2eSh6+hAUUkKA1hbQ4Dwu9isq1puEI1++sGIDzw/h61K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbxXFIr5zbZBpTxz7u+LIN0TlDjb8DiHM++SlMEo/ez6EUZg/
	vEt9UUVkToAa3Q0rt95VmDU8M9ha+puNl+kTcJsGQVJ0Q08YylaL
X-Gm-Gg: ASbGnctzakhpwrR/EEpJWTavsYleDfV3lXV4FvB9hahBL6ncsbFZni/Jjm/pZemre+B
	zEb5Qt1EgVPBm6SpQIzRsdXpCQjay0kyEmQg3xZJMzlSkxashQftnnSX63MOTQfDdV2DvP62ttJ
	z9JuQSotOM2bQdGJiSOXlCovuEgkLujI2AYr2euaGi5t0eWq+XSTNUNOlXSHWW0kBb2/djljF11
	5NJzrG3efLthps7VDcsdhYmtFqp4aTOPX1BVkm2NpSzUtXcwIO5lpE/h6n/PnAGYOggaJ4WJacr
	guQZf489Sp/3gutLF8MAmSe2HYXRPfpl0o/ONYRJkr1ICaY=
X-Google-Smtp-Source: AGHT+IE+R/i05xOcYuGx3CfeQWjqyk51P8QEx7sJ9GSjo27w65ZKSBhtkEi/1BOtkUVqsIGrFOr2LQ==
X-Received: by 2002:ad4:5443:0:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6dc8ca8ef8cmr211818766d6.25.1734392443062;
        Mon, 16 Dec 2024 15:40:43 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd257075sm32856486d6.35.2024.12.16.15.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:40:42 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A31161200043;
	Mon, 16 Dec 2024 18:40:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 16 Dec 2024 18:40:41 -0500
X-ME-Sender: <xms:ebpgZ52D8zWYnz2ZJ0FY_aMdfv-0I-mkiDJplK6xISkAunZ0Hce5Lg>
    <xme:ebpgZwE0oINyz40r3qbrD7sFBGEUeRs-oalXb7zXGGcdGqX341SA00loi03wEvPSz
    BS6vX7NN7BuLs8oKw>
X-ME-Received: <xmr:ebpgZ55iO8AAKFU-KQ9RYyvED7TDU5A184N99y1ccG1ZUuqXI24_jaEO64Bv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieev
    tdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihi
    lhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsth
    horghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgesshhushgv
    rdgtiidprhgtphhtthhopehjhhhusggsrghrugesnhhvihguihgrrdgtohhmpdhrtghpth
    htoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopegr
    khhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghhrvg
    hgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:ebpgZ21dbmYz04xcmrPk4_ZP4YKwFr-vQjCQfPxUfUD-LRDM52LW8w>
    <xmx:ebpgZ8F5racZd9B8LbaEBBVah2m_Epe7iHnwaY6bLegKVd6696p3mg>
    <xmx:ebpgZ3_ZEl1KTSeQ4cMrp9EavvJT3_WkxbfUnxBJhBGPzxYkqZK3qg>
    <xmx:ebpgZ5lGIKYK0aazvH9TdYq8Nhsoz0xvcDgLkARpAo6HxqxtjsEw8A>
    <xmx:ebpgZwFS6Ib0yzZal4AFd5ciLRT1bHdtloxZIHxf9hBdUxoI_JuV9EXB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 18:40:41 -0500 (EST)
Date: Mon, 16 Dec 2024 15:40:40 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v11 8/8] task: rust: rework how current is accessed
Message-ID: <Z2C6eAMnniTnxTX3@tardis.local>
References: <20241211-vma-v11-0-466640428fc3@google.com>
 <20241211-vma-v11-8-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-vma-v11-8-466640428fc3@google.com>

On Wed, Dec 11, 2024 at 10:37:12AM +0000, Alice Ryhl wrote:
> Introduce a new type called `CurrentTask` that lets you perform various
> operations that are only safe on the `current` task. Use the new type to
> provide a way to access the current mm without incrementing its
> refcount.
> 
> With this change, you can write stuff such as
> 
> 	let vma = current!().mm().lock_vma_under_rcu(addr);
> 
> without incrementing any refcounts.
> 
> This replaces the existing abstractions for accessing the current pid
> namespace. With the old approach, every field access to current involves
> both a macro and a unsafe helper function. The new approach simplifies
> that to a single safe function on the `CurrentTask` type. This makes it
> less heavy-weight to add additional current accessors in the future.
> 
> That said, creating a `CurrentTask` type like the one in this patch
> requires that we are careful to ensure that it cannot escape the current
> task or otherwise access things after they are freed. To do this, I
> declared that it cannot escape the current "task context" where I
> defined a "task context" as essentially the region in which `current`
> remains unchanged. So e.g., release_task() or begin_new_exec() would
> leave the task context.
> 
> If a userspace thread returns to userspace and later makes another
> syscall, then I consider the two syscalls to be different task contexts.
> This allows values stored in that task to be modified between syscalls,
> even if they're guaranteed to be immutable during a syscall.
> 
> Ensuring correctness of `CurrentTask` is slightly tricky if we also want
> the ability to have a safe `kthread_use_mm()` implementation in Rust. To
> support that safely, there are two patterns we need to ensure are safe:
> 
> 	// Case 1: current!() called inside the scope.
> 	let mm;
> 	kthread_use_mm(some_mm, || {
> 	    mm = current!().mm();
> 	});
> 	drop(some_mm);
> 	mm.do_something(); // UAF
> 
> and:
> 
> 	// Case 2: current!() called before the scope.
> 	let mm;
> 	let task = current!();
> 	kthread_use_mm(some_mm, || {
> 	    mm = task.mm();
> 	});
> 	drop(some_mm);
> 	mm.do_something(); // UAF
> 
> The existing `current!()` abstraction already natively prevents the
> first case: The `&CurrentTask` would be tied to the inner scope, so the
> borrow-checker ensures that no reference derived from it can escape the
> scope.
> 
> Fixing the second case is a bit more tricky. The solution is to
> essentially pretend that the contents of the scope execute on an
> different thread, which means that only thread-safe types can cross the
> boundary. Since `CurrentTask` is marked `NotThreadSafe`, attempts to
> move it to another thread will fail, and this includes our fake pretend
> thread boundary.
> 
> This has the disadvantage that other types that aren't thread-safe for
> reasons unrelated to `current` also cannot be moved across the
> `kthread_use_mm()` boundary. I consider this an acceptable tradeoff.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/mm.rs   |  22 ----
>  rust/kernel/task.rs | 284 ++++++++++++++++++++++++++++++----------------------
>  2 files changed, 167 insertions(+), 139 deletions(-)
> 
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 50f4861ae4b9..f7d1079391ef 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -142,28 +142,6 @@ fn deref(&self) -> &MmWithUser {
>  
>  // These methods are safe to call even if `mm_users` is zero.
>  impl Mm {
> -    /// Call `mmgrab` on `current.mm`.
> -    #[inline]
> -    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> -        // SAFETY: It's safe to get the `mm` field from current.
> -        let mm = unsafe {
> -            let current = bindings::get_current();
> -            (*current).mm
> -        };
> -
> -        if mm.is_null() {
> -            return None;
> -        }
> -
> -        // SAFETY: The value of `current->mm` is guaranteed to be null or a valid `mm_struct`. We
> -        // just checked that it's not null. Furthermore, the returned `&Mm` is valid only for the
> -        // duration of this function, and `current->mm` will stay valid for that long.
> -        let mm = unsafe { Mm::from_raw(mm) };
> -
> -        // This increments the refcount using `mmgrab`.
> -        Some(ARef::from(mm))
> -    }
> -

This is removed because of no user? If so, maybe don't introduce this at
all in the earlier patch of this series? The rest looks good to me.

Regards,
Boqun

>      /// Returns a raw pointer to the inner `mm_struct`.
>      #[inline]
>      pub fn as_raw(&self) -> *mut bindings::mm_struct {
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 07bc22a7645c..8c1ee46c03eb 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -7,6 +7,7 @@
>  use crate::{
>      bindings,
>      ffi::{c_int, c_long, c_uint},
> +    mm::MmWithUser,
>      pid_namespace::PidNamespace,
>      types::{ARef, NotThreadSafe, Opaque},
>  };
> @@ -31,22 +32,20 @@
[...]

