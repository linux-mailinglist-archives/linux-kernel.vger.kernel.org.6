Return-Path: <linux-kernel+bounces-418637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093AD9D63AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6F12828C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D01DFDAD;
	Fri, 22 Nov 2024 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dItPfKPs"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC11DF986;
	Fri, 22 Nov 2024 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298634; cv=none; b=gLKxoevQyixGwMR82/gemWNZGslupK5dz8iWi85g39LMQ4cOnOsOTMCJZhXDY6McEZMVEV7ypDlvjHFf8EhzSNgKoePXbfK1vAvVmfbcgVGhSI80pLQtUbplqBsNCSx5WHn2aSi0CARxF89xQd/eGK/DuMxwAOaTugeVrPq6VR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298634; c=relaxed/simple;
	bh=fo9z8tVhmvE1WMyuy+e2SpK3hT/7R1jQ51ySImC9s0E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QznM9B659Jl8r56Hf1JViPKJ2upgWtXWDeJYMvpL0t5MaBn/yfebB1jxEQueqh5x8PWlfTQvWRV/49Kj8b1X/wVYZGGPEiKVNPiEm4xLUr+LxDsc2/XujHjKVowAaJEhPECO4b77FCG6qyc4iCWxDX5rN+A+r2lioS/ziLZrQT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dItPfKPs; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4609967ab7eso15761361cf.3;
        Fri, 22 Nov 2024 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732298631; x=1732903431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyQ4a39Lo6xL3ZOkg9Xh74/gk7J/C279DSGOjmi1ezA=;
        b=dItPfKPsydxio6HeOMaPXimT0ygpyR3lXg4vshPwN4UIOIcGfUvhgeWf/xVE0C7adE
         V7SnL3h60lxOU77eIdMT8A038vCJVVWUpAm5Wedfo3xDExPtuy3NHYNUiI8W/tkcLF3U
         m1MPdETtYWCYXh3004pFyfyNhCaklLZvgxPir6qWRlrdEpQpxiKj+G4JqRjZG4ziF7f1
         AAQG45IaTk4srNH4asDlHpkxrrJ489pZ8m6hI+Z/rLz/O2Q8p2Wf8Hn1Nv27MPYbMxAG
         tVxGEDiA5iYIr5nY5L8DZADj2rVRMeuPOZ5tzKDMWX5cgbEdxOvElC3+DX9+wZY35bKf
         p5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298631; x=1732903431;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyQ4a39Lo6xL3ZOkg9Xh74/gk7J/C279DSGOjmi1ezA=;
        b=cZ1R+q7DA6gDXIbVMbCYqfKGocvpCruoo+uXRaqk9kwrJ0tLAc5YBqvHVoAO7g8tpL
         zQc25E7b4cFdb72NwtqeMP6lo24NVFkQcPbc81evtjsyY93zvoFmNEAib5B9jkqwGPL2
         S0NMLzcE2l9+uPQnPuTNlg0Qxkv9B7hUDzfXyteC9ehiQ3/6AqxVMTzB/mJvLWVDirjd
         bZLyPsp0XyRZ4ycgvXpqm3faEiswX2dBdi4PK+p3KnrtyvBb3GmnB8ce5AgfzwV88IPZ
         I/xPMYAGv3HI4vZEScYne7aLlO5A/gkVHN8nBY6fL1iqFtbZz275f3DE19+50krZt83t
         D5zg==
X-Forwarded-Encrypted: i=1; AJvYcCUAUumcA4o4bNVAY+l94z1bLIdKyQzgkV/k+dmwpnNexNfaBvRJ84glo5BzvIi0I3NfA0eO5786X4k2FJ4=@vger.kernel.org, AJvYcCVVXr5Y39reI4H2PwPi6Id1A/EA3j6lC0BlyC1cL3UTPoi3qIPLYCjMsoVRpP+OhspPHo8a0GFPs3RUEiVeZoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/eYYB4FFu5EmU5spvAsdNFHqFE8ezyr903H5n3XI3pIALidm0
	XKIyxBAOwiwNKYoMDLXNjT0m449dRyn/dJ8rZl/gig01yNtYUdSy
X-Gm-Gg: ASbGncsZ6CNYpQJ73uJJl8a9iyS/kOLuQY3b6AisdAB6j/uU9Kaz/EWtSbYxQCux8jg
	L7Op7OA2T1wx3gAspz3no+yKWK6rNXvMQcuKOWFBubLe0fcRHe0Qbrg8FUB1YkXJTJbgmbDIdhv
	cTHzyhZkE3Ii9b7nQSobp9T8lv7VABwmfnuNBx037Bq8QQoL0gPCpm44sMvFPDjCiSOxBGnCF33
	GkEsSE5/sbnpJYKVOOjux3JAuwRlnLnG3nhWSInOdRitPpzV6r0Gxiy6tUCrx3X++nZeREy/iTU
	oDI8iSXZo28xoE+jDAT3/zAh4R6N35kBS8TbnDcz
X-Google-Smtp-Source: AGHT+IGFAFc7OWIyavb5BtUbqFJ5IGEgdtl2dxH04LafA2+Go9twvT6FtggFGFkQV4F4YRIFJAlu3g==
X-Received: by 2002:a05:622a:4cf:b0:461:48f9:44e2 with SMTP id d75a77b69052e-4653d3e1205mr54132261cf.0.1732298631370;
        Fri, 22 Nov 2024 10:03:51 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c3ee449sm14406221cf.26.2024.11.22.10.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 10:03:50 -0800 (PST)
Message-ID: <6740c786.050a0220.31315a.5363@mx.google.com>
X-Google-Original-Message-ID: <Z0DHhLwTaqaGqdES@winterfell.>
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3394D1200043;
	Fri, 22 Nov 2024 13:03:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 22 Nov 2024 13:03:50 -0500
X-ME-Sender: <xms:hsdAZ_KlysnpUkw5tI714TKnjzhRcONnatYQY4EU6nowUWPoZbh5CQ>
    <xme:hsdAZzIwbhv1oNOCe2gttAGFvs_8mQ4qDNxoJlavJfoEwKTxFPF906k-Q3pyLkFsS
    EhM72wnSWY61yovHw>
X-ME-Received: <xmr:hsdAZ3vJr25Kglc2On98JTckCLkD7Po9jQu8lniK4vDl9149_aPz2zsgbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepuedttddvuedvudehffdvjeegtddvkedvleethfek
    udetgeejffekleeghfevveetnecuffhomhgrihhnpehmmhhifhhmmhdrihhsnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
    pdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehvsggrsghkrgesshhushgvrdgtiidprhgtphhtthhopehjhhhusggsrg
    hrugesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrth
    hiohhnrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhi
    ohhnrdhorhhg
X-ME-Proxy: <xmx:hsdAZ4a3JLzansxd34s7kxC9zRAqEL5L4DgCBgbSQ8G-xQJFTAAMdA>
    <xmx:hsdAZ2ZMULiRMtsWn2psejXe6Uo0504AB3w78cNDiYPcgUAmCOZ4gg>
    <xmx:hsdAZ8DHwgEvOHrjbvYF1qnx7mAGFgxR3_N-Y0CUyxvO4vMbT0YApQ>
    <xmx:hsdAZ0YeA9eo9OyW2HUuUVnvoBguF5uffhH44kYNPOhJW6QAOdZ4Lw>
    <xmx:hsdAZ6qUv_7rJJf7KEhcwxpta9o0Hc57y1TFtmxtidc64qjHnZsop84x>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Nov 2024 13:03:49 -0500 (EST)
Date: Fri, 22 Nov 2024 10:03:48 -0800
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
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
 <20241122-vma-v9-8-7127bfcdd54e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-vma-v9-8-7127bfcdd54e@google.com>

On Fri, Nov 22, 2024 at 03:40:33PM +0000, Alice Ryhl wrote:
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
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Reviewers: Does accessing task->mm on a non-current task require rcu
> protection?
> 
> Christian: If you submit the PidNamespace abstractions this cycle, I'll
> update this to also apply to PidNamespace.
> ---
>  rust/kernel/mm.rs   | 22 ------------------
>  rust/kernel/task.rs | 64 ++++++++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 51 insertions(+), 35 deletions(-)
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
>      /// Returns a raw pointer to the inner `mm_struct`.
>      #[inline]
>      pub fn as_raw(&self) -> *mut bindings::mm_struct {
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 9e59d86da42d..103d235eb844 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -94,6 +94,26 @@ unsafe impl Send for Task {}
>  // synchronised by C code (e.g., `signal_pending`).
>  unsafe impl Sync for Task {}
>  
> +/// Represents a [`Task`] obtained from the `current` global.
> +///
> +/// This type exists to provide more efficient operations that are only valid on the current task.
> +/// For example, to retrieve the pid-namespace of a task, you must use rcu protection unless it is
> +/// the current task.
> +///
> +/// # Invariants
> +///
> +/// Must be equal to `current` of some thread that is currently running somewhere.
> +pub struct CurrentTask(Task);
> +

I think you need to make `CurrentTask` `!Sync`, right? Otherwise, other
threads can access the shared reference of a `CurrentTask` and the ->mm
field. I'm thinking if we have a scoped thread/workqueue support in the
future:

	let task = current!();
	Workqueue::scoped(|s| {
	    s.spawn(|| {
	        let mm = task.mm();
		// do something with the mm
	    });
	});

> +// Make all `Task` methods available on `CurrentTask`.
> +impl Deref for CurrentTask {
> +    type Target = Task;
> +    #[inline]
> +    fn deref(&self) -> &Task {
> +        &self.0
> +    }
> +}
> +
>  /// The type of process identifiers (PIDs).
>  type Pid = bindings::pid_t;
>  
> @@ -121,27 +141,25 @@ pub fn current_raw() -> *mut bindings::task_struct {
>      /// # Safety
>      ///
>      /// Callers must ensure that the returned object doesn't outlive the current task/thread.
> -    pub unsafe fn current() -> impl Deref<Target = Task> {
> -        struct TaskRef<'a> {
> -            task: &'a Task,
> -            _not_send: NotThreadSafe,
> +    pub unsafe fn current() -> impl Deref<Target = CurrentTask> {
> +        struct TaskRef {
> +            task: *const CurrentTask,
>          }
>  
> -        impl Deref for TaskRef<'_> {
> -            type Target = Task;
> +        impl Deref for TaskRef {
> +            type Target = CurrentTask;
>  
>              fn deref(&self) -> &Self::Target {
> -                self.task
> +                // SAFETY: The returned reference borrows from this `TaskRef`, so it cannot outlive
> +                // the `TaskRef`, which the caller of `Task::current()` has promised will not
> +                // outlive the task/thread for which `self.task` is the `current` pointer. Thus, it
> +                // is okay to return a `CurrentTask` reference here.
> +                unsafe { &*self.task }
>              }
>          }
>  
> -        let current = Task::current_raw();
>          TaskRef {
> -            // SAFETY: If the current thread is still running, the current task is valid. Given
> -            // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
> -            // (where it could potentially outlive the caller).
> -            task: unsafe { &*current.cast() },
> -            _not_send: NotThreadSafe,
> +            task: Task::current_raw().cast(),
>          }
>      }
>  
> @@ -203,6 +221,26 @@ pub fn wake_up(&self) {
>      }
>  }
>  
> +impl CurrentTask {
> +    /// Access the address space of this task.
> +    ///
> +    /// To increment the refcount of the referenced `mm`, you can use `ARef::from`.
> +    #[inline]
> +    pub fn mm(&self) -> Option<&MmWithUser> {

Hmm... similar issue, `MmWithUser` is `Sync`.

> +        let mm = unsafe { (*self.as_ptr()).mm };
> +
> +        if mm.is_null() {
> +            None
> +        } else {
> +            // SAFETY: If `current->mm` is non-null, then it references a valid mm with a non-zero
> +            // value of `mm_users`. The returned `&MmWithUser` borrows from `CurrentTask`, so the
> +            // `&MmWithUser` cannot escape the current task, meaning `mm_users` can't reach zero
> +            // while the reference is still live.

Regards,
Boqun

> +            Some(unsafe { MmWithUser::from_raw(mm) })
> +        }
> +    }
> +}
> +
>  // SAFETY: The type invariants guarantee that `Task` is always refcounted.
>  unsafe impl crate::types::AlwaysRefCounted for Task {
>      fn inc_ref(&self) {
> 
> -- 
> 2.47.0.371.ga323438b13-goog
> 

