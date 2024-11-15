Return-Path: <linux-kernel+bounces-410607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE19CDDF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09C6282D25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075C01BC09F;
	Fri, 15 Nov 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QSLtnUBF"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8BD1BAED6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672011; cv=none; b=UkIl6cPBJVU4pte1r8fJqdKecYGO/zH16Ve/aYEdX7mzXMBFLa09XEsRROc0ywRVDfCvFLYp7JQ4/DgqL62mEmmgxGp6xrYAk9AWGXxgePycyfndjN1YDGP5ajfR4B7TbYTohPCvALmP8i0/5m3yBY+aNl/uEN2OxfvmJfmnfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672011; c=relaxed/simple;
	bh=kbx9VYnWmlvTMMs5Ll4X8oFALQ4tH8XIgm+2u4+yKhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+ErWDyOnONBFE2NybTAeM0rVFNWfJpI/9LvmeJCbqP4YKImMnMRZpXzxAFD6uooBUcsXUlfaSZlqJkPdNaQIH6tbc0+z0g++YMCnp4HBOtYt+ng18nLACOXHxTV3QsBCxL3/WbIyv342+T/6TPQtd7hZmk6Y7BHsTdvzcO//YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QSLtnUBF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4609e784352so11429751cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731672006; x=1732276806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=brlXMznUgTmtgicpz9djNJEIMcRyJv2TirXu6v3ayi4=;
        b=QSLtnUBFUIRYghBrupnAw/8eW+y6ZEcU5unSvJWRdTJk0Mfd3harkU6PKGKk/8xZp1
         6FLKrquqszgSH0DtCAz4V/DFPa31SiKjIWh/UjqZRfneqEH5N/RHDwkb5aDqRa2ifpww
         yZ/fOEKS4yzHnIgMmrCwXcizCd82UeFgiBMQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731672006; x=1732276806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brlXMznUgTmtgicpz9djNJEIMcRyJv2TirXu6v3ayi4=;
        b=TTmiI6TFikGVKs5nXAB1cOWQ6T9NfZZr2waI/oaZuFWWduNP+It7HFtOWRDzJIviUs
         tKF+rjdBfXoLYvIu7EyIErHqajiWwXa8KkAHsX6wriPnNJaRk6DJxPe3tE6WCQHv8+ed
         VgRZMqbbWb1iVBRBZbEesWwcZyQ2BSoFy7h4w/AUFEqlnz47pyGAXMJCf6Q4wu1x1VwU
         i84X15EP9XG6aIfx9UPn7t4MDmOL6WGBk+Poqj+Z0mbVALUS5rIb/N/OuV8lSGwoTgzr
         JQx87Fz7xqa4GIyuGKHOFVBmDS29BwRC0EQJxNZqMg366YUIdoPOLeBK770XmcuDfWJX
         A8+A==
X-Forwarded-Encrypted: i=1; AJvYcCX+Ct12W8My0uPmd6h+cCaIuvK2rrqu/FNiTnwbgXSeLZ3sB1PaRwLoBjo2qye1Wx9SjevE6xpOho9699g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pXXEQeIQ9xY+efLmnyyj3yMqVEAt5uHM9qcjnzLOZ0KeS+Me
	5LZUxxToCHC2wXcZwpSMPs2yGFG7JG2a2bOrTQFmAgxd68mso9MCeiOCaZGxmZ80FyPKdscYIyI
	k2Cks9k5UizY2yZU+O5rjXrMEYuS+/WQjE7duaGPmNnvXsb52
X-Google-Smtp-Source: AGHT+IF/qHONadJWYHH+WIIKAopg6niokdJFzl35adihxNbxleHpbM0Tg20wV6W+iVBzlcgYoetZDy1dbmCMAk96sao=
X-Received: by 2002:a05:622a:11c9:b0:460:e7f5:1bf with SMTP id
 d75a77b69052e-46363ec5cbdmr25913251cf.51.1731672005704; Fri, 15 Nov 2024
 04:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114070905.48901-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20241114070905.48901-1-zhangtianci.1997@bytedance.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 15 Nov 2024 12:59:54 +0100
Message-ID: <CAJfpegsF9iYG04YkA0AOKvsrg0hua3JGw=Phq=qeOurgqk_OuA@mail.gmail.com>
Subject: Re: [PATCH] fuse: check attributes staleness on fuse_iget()
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: multipart/mixed; boundary="000000000000c4ca390626f24e6f"

--000000000000c4ca390626f24e6f
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 08:12, Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Function fuse_direntplus_link() might call fuse_iget() to initialize a new
> fuse_inode and change its attributes. If fi->attr_version is always
> initialized with 0, even if the attributes returned by the FUSE_READDIR
> request is staled, as the new fi->attr_version is 0, fuse_change_attributes
> will still set the staled attributes to inode. This wrong behaviour may
> cause file size inconsistency even when there is no changes from
> server-side.

Thanks for working on this.

I have some comments, see below.

> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -173,6 +173,7 @@ static void fuse_evict_inode(struct inode *inode)
>                         fuse_cleanup_submount_lookup(fc, fi->submount_lookup);
>                         fi->submount_lookup = NULL;
>                 }
> +               atomic64_inc(&fc->evict_ctr);

I think this should only be done if (inode->i_nlink > 0), because if
the file/directory was removed, then the race between another lookup
cannot happen.

> @@ -426,7 +427,8 @@ static int fuse_inode_set(struct inode *inode, void *_nodeidp)
>
>  struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>                         int generation, struct fuse_attr *attr,
> -                       u64 attr_valid, u64 attr_version)
> +                       u64 attr_valid, u64 attr_version,
> +                       u64 evict_ctr)
>  {
>         struct inode *inode;
>         struct fuse_inode *fi;
> @@ -488,6 +490,10 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>         spin_unlock(&fi->lock);
>  done:
>         fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
> +       spin_lock(&fi->lock);
> +       if (evict_ctr < fuse_get_evict_ctr(fc))
> +               fuse_invalidate_attr(inode);

Similarly, this should not be done on creation (attr_version == 0),
since in case of a brand new inode the previous inode state cannot
have any effect on it.

The other case that may be worth taking special care of is when the
inode is already in the cache.  This happens for example on lookup of
hard links.  This is the (fi->attr_version > 0) case where we can rely
on the validity of attr_version.  I.e. the attr_version comparison in
fuse_change_attributes() will make sure the attributes are only
updated if necessary, no need to check evict_ctr.

So the only case that needs evict_ctr verification is (attr_version !=
0 && fi->attr_version == 0).

One other thing: I don't like the fact that the invalid mask is first
cleared in fuse_change_attributes_common(), then reset in
fuse_invalidate_attr().  It would be cleaner to not clear the mask in
the first place.

Attaching an untested incremental patch.  Can you please review and test?

Thanks,
Miklos

--000000000000c4ca390626f24e6f
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-evict-race-incremental.patch"
Content-Disposition: attachment; 
	filename="fuse-evict-race-incremental.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3iorc5z0>
X-Attachment-Id: f_m3iorc5z0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jCmluZGV4IDdkMGEwZmFi
NjkyMC4uNTliZTI4Nzc3ODZmIDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rpci5jCisrKyBiL2ZzL2Z1
c2UvZGlyLmMKQEAgLTY5Miw4ICs2OTIsNyBAQCBzdGF0aWMgaW50IGZ1c2VfY3JlYXRlX29wZW4o
c3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBpbm9kZSAqZGlyLAogCWZmLT5ub2RlaWQg
PSBvdXRlbnRyeS5ub2RlaWQ7CiAJZmYtPm9wZW5fZmxhZ3MgPSBvdXRvcGVucC0+b3Blbl9mbGFn
czsKIAlpbm9kZSA9IGZ1c2VfaWdldChkaXItPmlfc2IsIG91dGVudHJ5Lm5vZGVpZCwgb3V0ZW50
cnkuZ2VuZXJhdGlvbiwKLQkJCSAgJm91dGVudHJ5LmF0dHIsIEFUVFJfVElNRU9VVCgmb3V0ZW50
cnkpLCAwLAotCQkJICBmdXNlX2dldF9ldmljdF9jdHIoZm0tPmZjKSk7CisJCQkgICZvdXRlbnRy
eS5hdHRyLCBBVFRSX1RJTUVPVVQoJm91dGVudHJ5KSwgMCwgMCk7CiAJaWYgKCFpbm9kZSkgewog
CQlmbGFncyAmPSB+KE9fQ1JFQVQgfCBPX0VYQ0wgfCBPX1RSVU5DKTsKIAkJZnVzZV9zeW5jX3Jl
bGVhc2UoTlVMTCwgZmYsIGZsYWdzKTsKQEAgLTgyNCw4ICs4MjMsNyBAQCBzdGF0aWMgaW50IGNy
ZWF0ZV9uZXdfZW50cnkoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBmdXNlX21vdW50
ICpmbSwKIAkJZ290byBvdXRfcHV0X2ZvcmdldF9yZXE7CiAKIAlpbm9kZSA9IGZ1c2VfaWdldChk
aXItPmlfc2IsIG91dGFyZy5ub2RlaWQsIG91dGFyZy5nZW5lcmF0aW9uLAotCQkJICAmb3V0YXJn
LmF0dHIsIEFUVFJfVElNRU9VVCgmb3V0YXJnKSwgMCwKLQkJCSAgZnVzZV9nZXRfZXZpY3RfY3Ry
KGZtLT5mYykpOworCQkJICAmb3V0YXJnLmF0dHIsIEFUVFJfVElNRU9VVCgmb3V0YXJnKSwgMCwg
MCk7CiAJaWYgKCFpbm9kZSkgewogCQlmdXNlX3F1ZXVlX2ZvcmdldChmbS0+ZmMsIGZvcmdldCwg
b3V0YXJnLm5vZGVpZCwgMSk7CiAJCXJldHVybiAtRU5PTUVNOwpAQCAtMjAzMSw3ICsyMDI5LDcg
QEAgaW50IGZ1c2VfZG9fc2V0YXR0cihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGRl
bnRyeSAqZGVudHJ5LAogCiAJZnVzZV9jaGFuZ2VfYXR0cmlidXRlc19jb21tb24oaW5vZGUsICZv
dXRhcmcuYXR0ciwgTlVMTCwKIAkJCQkgICAgICBBVFRSX1RJTUVPVVQoJm91dGFyZyksCi0JCQkJ
ICAgICAgZnVzZV9nZXRfY2FjaGVfbWFzayhpbm9kZSkpOworCQkJCSAgICAgIGZ1c2VfZ2V0X2Nh
Y2hlX21hc2soaW5vZGUpLCAwKTsKIAlvbGRzaXplID0gaW5vZGUtPmlfc2l6ZTsKIAkvKiBzZWUg
dGhlIGNvbW1lbnQgaW4gZnVzZV9jaGFuZ2VfYXR0cmlidXRlcygpICovCiAJaWYgKCFpc193YiB8
fCBpc190cnVuY2F0ZSkKZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZnVzZV9pLmggYi9mcy9mdXNlL2Z1
c2VfaS5oCmluZGV4IGY5ZmYwZDAwMjlhYi4uYTk4ZmIyNDNiOTEzIDEwMDY0NAotLS0gYS9mcy9m
dXNlL2Z1c2VfaS5oCisrKyBiL2ZzL2Z1c2UvZnVzZV9pLmgKQEAgLTExMzYsNyArMTEzNiw4IEBA
IHZvaWQgZnVzZV9jaGFuZ2VfYXR0cmlidXRlcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
ZnVzZV9hdHRyICphdHRyLAogCiB2b2lkIGZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXNfY29tbW9uKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmdXNlX2F0dHIgKmF0dHIsCiAJCQkJICAgc3RydWN0
IGZ1c2Vfc3RhdHggKnN4LAotCQkJCSAgIHU2NCBhdHRyX3ZhbGlkLCB1MzIgY2FjaGVfbWFzayk7
CisJCQkJICAgdTY0IGF0dHJfdmFsaWQsIHUzMiBjYWNoZV9tYXNrLAorCQkJCSAgIHU2NCBldmlj
dF9jdHIpOwogCiB1MzIgZnVzZV9nZXRfY2FjaGVfbWFzayhzdHJ1Y3QgaW5vZGUgKmlub2RlKTsK
IApkaWZmIC0tZ2l0IGEvZnMvZnVzZS9pbm9kZS5jIGIvZnMvZnVzZS9pbm9kZS5jCmluZGV4IDg3
MmM2MWRkNTY2MS4uYzUxMDlkNWI4MDZmIDEwMDY0NAotLS0gYS9mcy9mdXNlL2lub2RlLmMKKysr
IGIvZnMvZnVzZS9pbm9kZS5jCkBAIC0xNzMsNyArMTczLDE0IEBAIHN0YXRpYyB2b2lkIGZ1c2Vf
ZXZpY3RfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkKIAkJCWZ1c2VfY2xlYW51cF9zdWJtb3Vu
dF9sb29rdXAoZmMsIGZpLT5zdWJtb3VudF9sb29rdXApOwogCQkJZmktPnN1Ym1vdW50X2xvb2t1
cCA9IE5VTEw7CiAJCX0KLQkJYXRvbWljNjRfaW5jKCZmYy0+ZXZpY3RfY3RyKTsKKwkJLyoKKwkJ
ICogRXZpY3Qgb2Ygbm9uLWRlbGV0ZWQgaW5vZGUgbWF5IHJhY2Ugd2l0aCBvdXRzdGFuZGluZwor
CQkgKiBMT09LVVAvUkVBRERJUlBMVVMgcmVxdWVzdHMgYW5kIHJlc3VsdCBpbiBpbmNvbnNpc3Rl
bmN5IHdoZW4KKwkJICogdGhlIHJlcXVlc3QgZmluaXNoZXMuICBEZWFsIHdpdGggdGhhdCBoZXJl
IGJ5IGJ1bXBpbmcgYQorCQkgKiBjb3VudGVyIHRoYXQgY2FuIGJlIGNvbXBhcmVkIHRvIHRoZSBz
dGFydGluZyB2YWx1ZS4KKwkJICovCisJCWlmIChpbm9kZS0+aV9ubGluayA+IDApCisJCQlhdG9t
aWM2NF9pbmMoJmZjLT5ldmljdF9jdHIpOwogCX0KIAlpZiAoU19JU1JFRyhpbm9kZS0+aV9tb2Rl
KSAmJiAhZnVzZV9pc19iYWQoaW5vZGUpKSB7CiAJCVdBUk5fT04oZmktPmlvY2FjaGVjdHIgIT0g
MCk7CkBAIC0yMDcsNyArMjE0LDggQEAgc3RhdGljIGlub190IGZ1c2Vfc3F1YXNoX2lubyh1NjQg
aW5vNjQpCiAKIHZvaWQgZnVzZV9jaGFuZ2VfYXR0cmlidXRlc19jb21tb24oc3RydWN0IGlub2Rl
ICppbm9kZSwgc3RydWN0IGZ1c2VfYXR0ciAqYXR0ciwKIAkJCQkgICBzdHJ1Y3QgZnVzZV9zdGF0
eCAqc3gsCi0JCQkJICAgdTY0IGF0dHJfdmFsaWQsIHUzMiBjYWNoZV9tYXNrKQorCQkJCSAgIHU2
NCBhdHRyX3ZhbGlkLCB1MzIgY2FjaGVfbWFzaywKKwkJCQkgICB1NjQgZXZpY3RfY3RyKQogewog
CXN0cnVjdCBmdXNlX2Nvbm4gKmZjID0gZ2V0X2Z1c2VfY29ubihpbm9kZSk7CiAJc3RydWN0IGZ1
c2VfaW5vZGUgKmZpID0gZ2V0X2Z1c2VfaW5vZGUoaW5vZGUpOwpAQCAtMjE2LDggKzIyNCwyMCBA
QCB2b2lkIGZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXNfY29tbW9uKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHN0cnVjdCBmdXNlX2F0dHIgKmF0dHIsCiAKIAlmaS0+YXR0cl92ZXJzaW9uID0gYXRvbWljNjRf
aW5jX3JldHVybigmZmMtPmF0dHJfdmVyc2lvbik7CiAJZmktPmlfdGltZSA9IGF0dHJfdmFsaWQ7
Ci0JLyogQ2xlYXIgYmFzaWMgc3RhdHMgZnJvbSBpbnZhbGlkIG1hc2sgKi8KLQlzZXRfbWFza19i
aXRzKCZmaS0+aW52YWxfbWFzaywgU1RBVFhfQkFTSUNfU1RBVFMsIDApOworCisJLyoKKwkgKiBD
bGVhciBiYXNpYyBzdGF0cyBmcm9tIGludmFsaWQgbWFzay4KKwkgKgorCSAqIERvbid0IGRvIHRo
aXMgaWYgdGhpcyBpcyBjb21pbmcgZnJvbSBhIGZ1c2VfaWdldCgpIGNhbGwgYW5kIHRoZXJlCisJ
ICogbWlnaHQgaGF2ZSBiZWVuIGEgcmFjaW5nIGV2aWN0IHdoaWNoIHdvdWxkJ3ZlIGludmFsaWRh
dGVkIHRoZSByZXN1bHQKKwkgKiBpZiB0aGUgYXR0cl92ZXJzaW9uIHdvdWxkJ3ZlIGJlZW4gcHJl
c2VydmVkLgorCSAqCisJICogIWV2aWN0X2N0ciAtPiB0aGlzIGlzIGNyZWF0ZQorCSAqIGZpLT5h
dHRyX3ZlcnNpb24gIT0gMCAtPiB0aGlzIGlzIG5vdCBhIG5ldyBpbm9kZQorCSAqIGV2aWN0X2N0
ciA9PSBmdXNlX2dldF9ldmljdF9jdHIoKSAtPiBubyBldmljdHMgd2hpbGUgZHVyaW5nIHJlcXVl
c3QKKwkgKi8KKwlpZiAoIWV2aWN0X2N0ciB8fCBmaS0+YXR0cl92ZXJzaW9uIHx8IGV2aWN0X2N0
ciA9PSBmdXNlX2dldF9ldmljdF9jdHIoZmMpKQorCQlzZXRfbWFza19iaXRzKCZmaS0+aW52YWxf
bWFzaywgU1RBVFhfQkFTSUNfU1RBVFMsIDApOwogCiAJaW5vZGUtPmlfaW5vICAgICA9IGZ1c2Vf
c3F1YXNoX2lubyhhdHRyLT5pbm8pOwogCWlub2RlLT5pX21vZGUgICAgPSAoaW5vZGUtPmlfbW9k
ZSAmIFNfSUZNVCkgfCAoYXR0ci0+bW9kZSAmIDA3Nzc3KTsKQEAgLTI5Niw5ICszMTYsOSBAQCB1
MzIgZnVzZV9nZXRfY2FjaGVfbWFzayhzdHJ1Y3QgaW5vZGUgKmlub2RlKQogCXJldHVybiBTVEFU
WF9NVElNRSB8IFNUQVRYX0NUSU1FIHwgU1RBVFhfU0laRTsKIH0KIAotdm9pZCBmdXNlX2NoYW5n
ZV9hdHRyaWJ1dGVzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmdXNlX2F0dHIgKmF0dHIs
Ci0JCQkgICAgc3RydWN0IGZ1c2Vfc3RhdHggKnN4LAotCQkJICAgIHU2NCBhdHRyX3ZhbGlkLCB1
NjQgYXR0cl92ZXJzaW9uKQorc3RhdGljIHZvaWQgZnVzZV9jaGFuZ2VfYXR0cmlidXRlc19pKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmdXNlX2F0dHIgKmF0dHIsCisJCQkJICAgICBzdHJ1
Y3QgZnVzZV9zdGF0eCAqc3gsIHU2NCBhdHRyX3ZhbGlkLAorCQkJCSAgICAgdTY0IGF0dHJfdmVy
c2lvbiwgdTY0IGV2aWN0X2N0cikKIHsKIAlzdHJ1Y3QgZnVzZV9jb25uICpmYyA9IGdldF9mdXNl
X2Nvbm4oaW5vZGUpOwogCXN0cnVjdCBmdXNlX2lub2RlICpmaSA9IGdldF9mdXNlX2lub2RlKGlu
b2RlKTsKQEAgLTMzMiw3ICszNTIsOCBAQCB2b2lkIGZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXMoc3Ry
dWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZ1c2VfYXR0ciAqYXR0ciwKIAl9CiAKIAlvbGRfbXRp
bWUgPSBpbm9kZV9nZXRfbXRpbWUoaW5vZGUpOwotCWZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXNfY29t
bW9uKGlub2RlLCBhdHRyLCBzeCwgYXR0cl92YWxpZCwgY2FjaGVfbWFzayk7CisJZnVzZV9jaGFu
Z2VfYXR0cmlidXRlc19jb21tb24oaW5vZGUsIGF0dHIsIHN4LCBhdHRyX3ZhbGlkLCBjYWNoZV9t
YXNrLAorCQkJCSAgICAgIGV2aWN0X2N0cik7CiAKIAlvbGRzaXplID0gaW5vZGUtPmlfc2l6ZTsK
IAkvKgpAQCAtMzczLDYgKzM5NCwxMyBAQCB2b2lkIGZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXMoc3Ry
dWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZ1c2VfYXR0ciAqYXR0ciwKIAkJZnVzZV9kYXhfZG9u
dGNhY2hlKGlub2RlLCBhdHRyLT5mbGFncyk7CiB9CiAKK3ZvaWQgZnVzZV9jaGFuZ2VfYXR0cmli
dXRlcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZnVzZV9hdHRyICphdHRyLAorCQkJICAg
IHN0cnVjdCBmdXNlX3N0YXR4ICpzeCwgdTY0IGF0dHJfdmFsaWQsCisJCQkgICAgdTY0IGF0dHJf
dmVyc2lvbikKK3sKKwlmdXNlX2NoYW5nZV9hdHRyaWJ1dGVzX2koaW5vZGUsIGF0dHIsIHN4LCBh
dHRyX3ZhbGlkLCBhdHRyX3ZlcnNpb24sIDApOworfQorCiBzdGF0aWMgdm9pZCBmdXNlX2luaXRf
c3VibW91bnRfbG9va3VwKHN0cnVjdCBmdXNlX3N1Ym1vdW50X2xvb2t1cCAqc2wsCiAJCQkJICAg
ICAgdTY0IG5vZGVpZCkKIHsKQEAgLTQ4OSwxMiArNTE3LDggQEAgc3RydWN0IGlub2RlICpmdXNl
X2lnZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdTY0IG5vZGVpZCwKIAlmaS0+bmxvb2t1cCsr
OwogCXNwaW5fdW5sb2NrKCZmaS0+bG9jayk7CiBkb25lOgotCWZ1c2VfY2hhbmdlX2F0dHJpYnV0
ZXMoaW5vZGUsIGF0dHIsIE5VTEwsIGF0dHJfdmFsaWQsIGF0dHJfdmVyc2lvbik7Ci0Jc3Bpbl9s
b2NrKCZmaS0+bG9jayk7Ci0JaWYgKGV2aWN0X2N0ciA8IGZ1c2VfZ2V0X2V2aWN0X2N0cihmYykp
Ci0JCWZ1c2VfaW52YWxpZGF0ZV9hdHRyKGlub2RlKTsKLQlzcGluX3VubG9jaygmZmktPmxvY2sp
OwotCisJZnVzZV9jaGFuZ2VfYXR0cmlidXRlc19pKGlub2RlLCBhdHRyLCBOVUxMLCBhdHRyX3Zh
bGlkLCBhdHRyX3ZlcnNpb24sCisJCQkJIGV2aWN0X2N0cik7CiAJcmV0dXJuIGlub2RlOwogfQog
Cg==
--000000000000c4ca390626f24e6f--

