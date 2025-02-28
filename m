Return-Path: <linux-kernel+bounces-538393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCB1A49819
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD781896B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2DD261569;
	Fri, 28 Feb 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFKUjfnn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1026038A;
	Fri, 28 Feb 2025 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741074; cv=none; b=sAG6ZBEiaU84OtifZWOMHix8TJmEq3+3hS1k2CG98ipZkMqeV6ewa+eJeUjctxJtd8MtTjhDbAixjnduuB3DIwYl8ArURKbLYPUylFvM39wYt2eWMDe88EIfk91fCuzk6eue0U0K0tw14uBJkGGMDvZF9CKy+WJE1G9rqqEvYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741074; c=relaxed/simple;
	bh=/vDcCubYLhs8N2hcwP3oNF+FZaC3degOyiCIi3m7V0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rPNzE+n1TwXwh+BGN7C+OsCaz7EF/c72MLzWtxSikPazPo49C+nWo+Wp4PpXVmGpKzbDoZOIwDE67QPAxrl/W1bPB+4/KHi78KD/K+hKUeEsT4pBlRnQbJwNM6NvE7/as14CaNdQgSLDVK4y1hulgFEjwmeR/3l7mVt9W8wB2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFKUjfnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6A8C4CED6;
	Fri, 28 Feb 2025 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740741073;
	bh=/vDcCubYLhs8N2hcwP3oNF+FZaC3degOyiCIi3m7V0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RFKUjfnnCWKa7g7KIX2wQ3ZOQmfiWg5gIN6jWL46WSTB/MjgGcOH7CDe1qLf+wPob
	 eBOg+ocilJQ+0HmKcOzf9B0tpiXJM9arLy+YGdsKe47j87wjrMkBMXrPDbpTzolPY3
	 K/AyeHBQnhdorddQgKiCqmb1SOW2g2111zIhB+qSsFIrs27Pw0IwbYfDsupvyXsd8c
	 9q/xt0qFyhAcuLBmEdRR0tuPWClAuXJnNGETN6XS0eAZ0y66+/pheMnyl3eO1vIZUc
	 VOdgwf4jBTanbdkJ/vASYmDyZdC9uRRZwDUOcRR6DCo/uzEJ2JKONq+Tp4f0wnIWUd
	 M6Q8OLpBktEpQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] Rust: Implement a unique reference type URef
 supplementing ARef
In-Reply-To: <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>
	(Oliver Mangold's message of "Fri, 21 Feb 2025 08:04:34 +0000")
References: <jeyp4dToznpiAQYWHAABrEBIHVfxaIf7ntexop3d2AXQgnlytw3J8YFkX8E8EFKc1-USf_fVZqKhEmuNGE3O0w==@protonmail.internalid>
	<SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 12:10:59 +0100
Message-ID: <87wmdamiik.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Oliver,

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> For usage with block-mq, we found that having a variant of ARef which is guaranteed to be unique is useful. As chances are it is useful in general, I implemented it as kernel::types::URef. The difference between ARef and URef is basically the same as between Arc and UniqueArc.

Wrap at 75 characters please :)

>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> ---
>  rust/kernel/block/mq/request.rs | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
>  1 file changed, 61 insertions(+), 36 deletions(-)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 55ddd50e8aaa..80dc9edef1b9 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -543,6 +543,12 @@ fn from(b: &T) -> Self {
>      }
>  }
>
> +impl<T: UniqueRefCounted> From<URef<T>> for ARef<T> {
> +    fn from(b: URef<T>) -> Self {
> +        UniqueRefCounted::unique_to_shared(b)
> +    }
> +}
> +
>  impl<T: AlwaysRefCounted> Drop for ARef<T> {
>      fn drop(&mut self) {
>          // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
> @@ -551,6 +557,119 @@ fn drop(&mut self) {
>      }
>  }
>
> +/// Types that are `AlwaysRefCounted` and can be safely converted to an `URef`
> +///

When the trait is unsafe, we need to specify the conditions under which
it is safe to implement:

# Safety

- Requirement 1
- Requirement 2
- etc

See `AlwaysRefCounted` for reference on formatting.

> +pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
> +    /// Checks if the the [ARef] is unique and convert it
> +    /// to an [URef] it that is that case.

Please use back ticks for types: [`ARef`], [`URref`]

> +    /// Otherwise it returns again an [ARef] to the same
> +    /// underlying object.
> +    fn try_shared_to_unique(this: ARef<Self>) -> Result<URef<Self>,ARef<Self>>;
> +    /// Converts the [URef] into an [ARef].
> +    fn unique_to_shared(this: URef<Self>) -> ARef<Self>;
> +}
> +
> +/// An unique owned reference to an always-reference-counted object.
> +///
> +/// It works the same ways as [`ARef`] but ensures that the reference is unique
> +/// and thus can be dereferenced mutably.
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
> +/// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> +pub struct URef<T: UniqueRefCounted> {
> +    ptr: NonNull<T>,
> +    _p: PhantomData<T>,
> +}
> +
> +// SAFETY: It is safe to send `URef<T>` to another thread when the underlying `T` is `Sync` because
> +// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
> +// `T` to be `Send` because any thread that has an `URef<T>` may ultimately access `T` using a
> +// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
> +unsafe impl<T: UniqueRefCounted + Sync + Send> Send for URef<T> {}
> +
> +// SAFETY: It is safe to send `&URef<T>` to another thread when the underlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
> +// it needs `T` to be `Send` because any thread that has a `&URef<T>` may clone it and get an
> +// `URef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
> +// example, when the reference count reaches zero and `T` is dropped.
> +unsafe impl<T: UniqueRefCounted + Sync + Send> Sync for URef<T> {}
> +
> +impl<T: UniqueRefCounted> URef<T> {

I would prefer `UniqueRef`. I know `ARef` has a different naming scheme,
but I think `UniqueRef` is sufficiently short and significantly more
descriptive than `URef`.

> +    /// Creates a new instance of [`URef`].
> +    ///
> +    /// It takes over an increment of the reference count on the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the reference count is set to such a value
> +    /// that a call to AlwaysRefCounted::dec_ref() will release the underlying object
> +    /// in the way which is expected when the last reference is dropped.
> +    /// Callers must not use the underlying object anymore --
> +    /// it is only safe to do so via the newly created [`URef`].
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> +        // INVARIANT: The safety requirements guarantee that the new instance now owns the
> +        // increment on the refcount.
> +        Self {
> +            ptr,
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Consumes the `URef`, returning a raw pointer.
> +    ///
> +    /// This function does not change the refcount. After calling this function, the caller is
> +    /// responsible for the refcount previously managed by the `URef`.
> +    pub fn into_raw(me: Self) -> NonNull<T> {
> +        ManuallyDrop::new(me).ptr
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> Deref for URef<T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> DerefMut for URef<T> {
> +
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid.
> +        unsafe { self.ptr.as_mut() }
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> From<&T> for URef<T> {
> +    /// Converts the [URef] into an [ARef] by calling [UniqueRefCounted::unique_to_shared] on it.
> +    fn from(b: &T) -> Self {
> +        b.inc_ref();
> +        // SAFETY: We just incremented the refcount above.
> +        unsafe { Self::from_raw(NonNull::from(b)) }
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> TryFrom<ARef<T>> for URef<T> {
> +    type Error = ARef<T>;
> +    /// Tries to convert the [ARef] to an [URef] by calling [UniqueRefCounted::try_shared_to_unique].
> +    /// In case the [ARef] is not unique it returns again an [ARef] to the same
> +    /// underlying object.
> +    fn try_from(b: ARef<T>) -> Result<URef<T>,Self::Error> {
> +        UniqueRefCounted::try_shared_to_unique(b)
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> Drop for URef<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that the `URef` owns the reference we're about to
> +        // decrement.
> +        unsafe { T::dec_ref(self.ptr) };
> +    }
> +}
> +
>  /// A sum type that always holds either a value of type `L` or `R`.
>  ///
>  /// # Examples
> ---

For your next version, can you run `make rustfmt`?:


diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 58556d417cae..49903fd0446e 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -542,13 +542,12 @@ fn drop(&mut self) {
 }
 
 /// Types that are `AlwaysRefCounted` and can be safely converted to an `URef`
-///
 pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
     /// Checks if the the [ARef] is unique and convert it
     /// to an [URef] it that is that case.
     /// Otherwise it returns again an [ARef] to the same
     /// underlying object.
-    fn try_shared_to_unique(this: ARef<Self>) -> Result<URef<Self>,ARef<Self>>;
+    fn try_shared_to_unique(this: ARef<Self>) -> Result<URef<Self>, ARef<Self>>;
     /// Converts the [URef] into an [ARef].
     fn unique_to_shared(this: URef<Self>) -> ARef<Self>;
 }
@@ -620,7 +619,6 @@ fn deref(&self) -> &Self::Target {
 }
 
 impl<T: UniqueRefCounted> DerefMut for URef<T> {
-
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY: The type invariants guarantee that the object is valid.
         unsafe { self.ptr.as_mut() }
@@ -638,10 +636,10 @@ fn from(b: &T) -> Self {
 
 impl<T: UniqueRefCounted> TryFrom<ARef<T>> for URef<T> {
     type Error = ARef<T>;
-    /// Tries to convert the [ARef] to an [URef] by calling [UniqueRefCounted::try_shared_to_unique].
-    /// In case the [ARef] is not unique it returns again an [ARef] to the same
-    /// underlying object.
-    fn try_from(b: ARef<T>) -> Result<URef<T>,Self::Error> {
+    /// Tries to convert the [ARef] to an [URef] by calling
+    /// [UniqueRefCounted::try_shared_to_unique]. In case the [ARef] is not unique it returns
+    /// again an [ARef] to the same underlying object.
+    fn try_from(b: ARef<T>) -> Result<URef<T>, Self::Error> {
         UniqueRefCounted::try_shared_to_unique(b)
     }
 }


Also it would be great if you include your "rust: for fix dec_ref for
URef<Request>" folded in.

Best regards,
Andreas Hindborg



