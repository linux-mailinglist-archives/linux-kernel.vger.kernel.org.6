Return-Path: <linux-kernel+bounces-328061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F2D977E77
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035ADB28BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56741D933B;
	Fri, 13 Sep 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YbL9OBWL"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E911D88D1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226833; cv=none; b=RLH3Xu6y2cKHvjBcqCF0YL5QiuD5dielbSpgV1VOpt3uVp9aiS1aupcSUpwe2IJmAs59lyuLcRQIRX+nr/47Ua94mGwN4E+S+RqzAFuAwXJY/iFCEmpij8xAwKlye8OLz86kvRteOkuXiKFSrv06J0N2Ch0v0FdnEMtLMDk+6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226833; c=relaxed/simple;
	bh=PyJxY8eRWiH+l03R50UsePfbsm/eAUXthUJtr3Urp5E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdjwzr3y7eMj7bemKht92tTqBCV5HSpXLqZELa3B52uSRxy4FGpS7ZpKGuzgth38GOfWCvw0XIsoGjWH8dczNVh7yPARpwpDj3tAsl4IWSMggQ+PXHqtdUVntlYPATcdjIWM2al8xoPqwRjqJYN0353sGXgOpyHKQGth7OOYBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YbL9OBWL; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726226829; x=1726486029;
	bh=pUnST86Gvvom+jk94p3EcSuO3F4gQCBoVIs6ZsKol9Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YbL9OBWLj3q1ADp+fiNOLaYTuZI6AI1okQcizeMKm4PLW/4GZ1qTopdjl3gnJXEfW
	 xXIKLN/JrCJFHC3xr1g3kobPhg+BMMtV8k9qKF7ZYvnNdxUP25p1KI+DNL3RTpac2A
	 rmxSW6JSdjqdgSEFkqLpsiDCNYv9s3Bit74Moi1mnW2+hfcxAAkDK4ovFfSXaTIBVC
	 ae3GKFn5EXCW1N2VbAch3E3cYoWla9vwlqdCCHQsy0YrurS2k6n5cDWADk2C1kyjC5
	 j6FUoXCNNnNa/7OjydhCmiiIbVv2v1edt5WOzkYSf4EQwQ9ms3nkmbwHeVoJgURm4k
	 WN56rpXAMIU0Q==
Date: Fri, 13 Sep 2024 11:27:05 +0000
To: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 3/3] WIP: rust: tarfs: use untrusted data API
Message-ID: <20240913112643.542914-4-benno.lossin@proton.me>
In-Reply-To: <20240913112643.542914-1-benno.lossin@proton.me>
References: <20240913112643.542914-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ac6388f0398c5179b26d80b493102c3459659c05
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As an example here is how tarfs could use the untrusted data API. There
are two calls to `untrusted()` outside of `Validator` implementations. I
don't know if the names are used for some logic at a later point, and I
didn't want to mark the name as untrusted, because then I would have to
change more of the vfs API. I think if the names are not used for any
logic, then they can just stay as `Untrusted<CString>`.
---
 fs/tarfs/defs.rs |   1 +
 fs/tarfs/tar.rs  | 143 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 99 insertions(+), 45 deletions(-)

diff --git a/fs/tarfs/defs.rs b/fs/tarfs/defs.rs
index 7481b75aaab2..db22e3299fef 100644
--- a/fs/tarfs/defs.rs
+++ b/fs/tarfs/defs.rs
@@ -70,6 +70,7 @@ pub struct DirEntry {
=20
     /// The super-block of a tarfs instance.
     #[repr(C)]
+    #[derive(Clone)]
     pub struct Header {
         /// The offset to the beginning of the inode-table.
         pub inode_table_offset: LE<u64>,
diff --git a/fs/tarfs/tar.rs b/fs/tarfs/tar.rs
index a3f6e468e566..8ca255306c8b 100644
--- a/fs/tarfs/tar.rs
+++ b/fs/tarfs/tar.rs
@@ -9,7 +9,14 @@
     inode::Type, iomap, sb, sb::SuperBlock, Offset, Stat,
 };
 use kernel::types::{ARef, Either, FromBytes, Locked};
-use kernel::{c_str, prelude::*, str::CString, user};
+use kernel::{
+    c_str,
+    prelude::*,
+    str::CString,
+    types::{Untrusted, Validator},
+    user,
+};
+use std::fs::DirEntry;
=20
 pub mod defs;
=20
@@ -29,7 +36,8 @@
=20
 static_assert!(SECTORS_PER_BLOCK > 0);
=20
-struct INodeData {
+#[allow(missing_docs)]
+pub struct INodeData {
     offset: u64,
     flags: u8,
 }
@@ -41,26 +49,13 @@ struct TarFs {
     mapper: inode::Mapper,
 }
=20
-impl TarFs {
-    fn iget(sb: &SuperBlock<Self>, ino: u64) -> Result<ARef<INode<Self>>> =
{
-        // Check that the inode number is valid.
-        let h =3D sb.data();
-        if ino =3D=3D 0 || ino > h.inode_count {
-            return Err(ENOENT);
-        }
+impl Validator for Inode {
+    type Input =3D [u8];
+    type Output =3D inode::Params<INodeData>;
+    type Err =3D Error;
=20
-        // Create an inode or find an existing (cached) one.
-        let mut inode =3D match sb.get_or_create_inode(ino)? {
-            Either::Left(existing) =3D> return Ok(existing),
-            Either::Right(new) =3D> new,
-        };
-
-        static_assert!((TARFS_BSIZE as usize) % size_of::<Inode>() =3D=3D =
0);
-
-        // Load inode details from storage.
-        let offset =3D h.inode_table_offset + (ino - 1) * u64::try_from(si=
ze_of::<Inode>())?;
-        let b =3D h.mapper.mapped_folio(offset.try_into()?)?;
-        let idata =3D Inode::from_bytes(&b, 0).ok_or(EIO)?;
+    fn validate(untrusted: &Untrusted<Self::Input>) -> Result<Self::Output=
, Self::Err> {
+        let idata =3D Inode::from_bytes(untrusted.untrusted(), 0).ok_or(EI=
O)?;
=20
         let mode =3D idata.mode.value();
=20
@@ -69,36 +64,21 @@ fn iget(sb: &SuperBlock<Self>, ino: u64) -> Result<ARef=
<INode<Self>>> {
             return Err(ENOENT);
         }
=20
-        const DIR_FOPS: file::Ops<TarFs> =3D file::Ops::new::<TarFs>();
-        const DIR_IOPS: inode::Ops<TarFs> =3D inode::Ops::new::<TarFs>();
-        const FILE_AOPS: address_space::Ops<TarFs> =3D iomap::ro_aops::<Ta=
rFs>();
-
         let size =3D idata.size.value();
         let doffset =3D idata.offset.value();
         let secs =3D u64::from(idata.lmtime.value()) | (u64::from(idata.hm=
time & 0xf) << 32);
         let ts =3D kernel::time::Timespec::new(secs, 0)?;
         let typ =3D match mode & fs::mode::S_IFMT {
-            fs::mode::S_IFREG =3D> {
-                inode
-                    .set_fops(file::Ops::generic_ro_file())
-                    .set_aops(FILE_AOPS);
-                Type::Reg
-            }
-            fs::mode::S_IFDIR =3D> {
-                inode.set_iops(DIR_IOPS).set_fops(DIR_FOPS);
-                Type::Dir
-            }
-            fs::mode::S_IFLNK =3D> {
-                inode.set_iops(inode::Ops::simple_symlink_inode());
-                Type::Lnk(Some(Self::get_link(sb, doffset, size)?))
-            }
+            fs::mode::S_IFREG =3D> Type::Reg,
+            fs::mode::S_IFDIR =3D> Type::Dir,
+            fs::mode::S_IFLNK =3D> Type::Lnk(None),
             fs::mode::S_IFSOCK =3D> Type::Sock,
             fs::mode::S_IFIFO =3D> Type::Fifo,
             fs::mode::S_IFCHR =3D> Type::Chr((doffset >> 32) as u32, doffs=
et as u32),
             fs::mode::S_IFBLK =3D> Type::Blk((doffset >> 32) as u32, doffs=
et as u32),
             _ =3D> return Err(ENOENT),
         };
-        inode.init(inode::Params {
+        Ok(inode::Params {
             typ,
             mode: mode & 0o777,
             size: size.try_into()?,
@@ -115,13 +95,86 @@ fn iget(sb: &SuperBlock<Self>, ino: u64) -> Result<ARe=
f<INode<Self>>> {
             },
         })
     }
+}
+
+impl Validator for Header {
+    type Input =3D [u8];
+    type Output =3D Self;
+    type Err =3D Error;
+
+    fn validate(
+        untrusted: &Untrusted<Self::Input>,
+    ) -> core::result::Result<Self::Output, Self::Err> {
+        Header::from_bytes(untrusted.untrusted(), 0)
+            .ok_or(EIO)
+            .cloned()
+    }
+}
+
+impl Validator for DirEntry {
+    type Input =3D [u8];
+    type Output =3D Self;
+    type Err =3D Error;
+
+    fn validate(
+        untrusted: &Untrusted<Self::Input>,
+    ) -> core::result::Result<Self::Output, Self::Err> {
+        let raw =3D DirEntry::from_bytes_to_slice(untrusted.untrusted()).o=
k_or(EIO)?;
+        // TODO: actually verify that the `raw` entry is correct.
+        Ok(raw)
+    }
+}
+
+impl TarFs {
+    fn iget(sb: &SuperBlock<Self>, ino: u64) -> Result<ARef<INode<Self>>> =
{
+        // Check that the inode number is valid.
+        let h =3D sb.data();
+        if ino =3D=3D 0 || ino > h.inode_count {
+            return Err(ENOENT);
+        }
+
+        // Create an inode or find an existing (cached) one.
+        let mut inode =3D match sb.get_or_create_inode(ino)? {
+            Either::Left(existing) =3D> return Ok(existing),
+            Either::Right(new) =3D> new,
+        };
+
+        static_assert!((TARFS_BSIZE as usize) % size_of::<Inode>() =3D=3D =
0);
+
+        // Load inode details from storage.
+        let offset =3D h.inode_table_offset + (ino - 1) * u64::try_from(si=
ze_of::<Inode>())?;
+        let b =3D h.mapper.mapped_folio(offset.try_into()?)?;
+
+        const DIR_FOPS: file::Ops<TarFs> =3D file::Ops::new::<TarFs>();
+        const DIR_IOPS: inode::Ops<TarFs> =3D inode::Ops::new::<TarFs>();
+        const FILE_AOPS: address_space::Ops<TarFs> =3D iomap::ro_aops::<Ta=
rFs>();
+
+        let mut params =3D b.deref().validate::<Inode>()?;
+        match &params.typ {
+            Type::Reg =3D> {
+                inode
+                    .set_fops(file::Ops::generic_ro_file())
+                    .set_aops(FILE_AOPS);
+            }
+            Type::Dir =3D> {
+                inode.set_iops(DIR_IOPS).set_fops(DIR_FOPS);
+            }
+            Type::Lnk(_) =3D> {
+                inode.set_iops(inode::Ops::simple_symlink_inode());
+                let doffset =3D params.value.offset;
+                params.typ =3D Type::Lnk(Some(Self::get_link(sb, doffset, =
params.size as u64)?));
+            }
+            _ =3D> {}
+        }
+        inode.init(params)
+    }
=20
     fn name_eq(sb: &SuperBlock<Self>, mut name: &[u8], offset: u64) -> Res=
ult<bool> {
         let ret =3D
             sb.data()
                 .mapper
                 .for_each_page(offset as Offset, name.len().try_into()?, |=
data| {
-                    if data !=3D &name[..data.len()] {
+                    if data.untrusted() !=3D &name[..data.len()] {
                         return Ok(Some(()));
                     }
                     name =3D &name[data.len()..];
@@ -135,7 +188,7 @@ fn read_name(sb: &SuperBlock<Self>, name: &mut [u8], of=
fset: u64) -> Result {
         sb.data()
             .mapper
             .for_each_page(offset as Offset, name.len().try_into()?, |data=
| {
-                name[copy_to..][..data.len()].copy_from_slice(data);
+                name[copy_to..][..data.len()].copy_from_slice(data.untrust=
ed());
                 copy_to +=3D data.len();
                 Ok(None::<()>)
             })?;
@@ -179,7 +232,7 @@ fn fill_super(
         let tarfs =3D {
             let offset =3D (scount - 1) * SECTOR_SIZE;
             let mapped =3D mapper.mapped_folio(offset.try_into()?)?;
-            let hdr =3D Header::from_bytes(&mapped, 0).ok_or(EIO)?;
+            let hdr =3D mapped.deref().validate::<Header>()?;
             let inode_table_offset =3D hdr.inode_table_offset.value();
             let inode_count =3D hdr.inode_count.value();
             drop(mapped);
@@ -316,7 +369,7 @@ fn lookup(
             parent.data().offset.try_into()?,
             parent.size(),
             |data| {
-                for e in DirEntry::from_bytes_to_slice(data).ok_or(EIO)? {
+                for e in data.validate::<DirEntry>()? {
                     if Self::name_eq(sb, name, e.name_offset.value())? {
                         return Ok(Some(Self::iget(sb, e.ino.value())?));
                     }
@@ -368,7 +421,7 @@ fn read_dir(
             inode.data().offset as i64 + pos,
             inode.size() - pos,
             |data| {
-                for e in DirEntry::from_bytes_to_slice(data).ok_or(EIO)? {
+                for e in data.validate::<DirEntry>()? {
                     let name_len =3D usize::try_from(e.name_len.value())?;
                     if name_len > name.len() {
                         name.resize(name_len, 0, GFP_NOFS)?;
--=20
2.46.0



