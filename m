Return-Path: <linux-kernel+bounces-302092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E13FC95F9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AFEB2114A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C547F79945;
	Mon, 26 Aug 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="L1MdCpJO"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D319198E6C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700612; cv=none; b=LgKP/4IxYkZWLehbx9RxX1Sfln6QLQ0/GPiFl1cj4WBo8OQsTzz6G9EyqybiQZXZzMmsOpmwlg+pW6uWb/A31tur66dZGCxNm0K8Q9uPkoH4ECBXS2rcgIgUkdxiRgbJ2en+ezaTmbG5KFc8Jq/NfhVt3tHTFItlwHW53HHWOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700612; c=relaxed/simple;
	bh=hcRvwF87oztYXFmspwLvuXVmC1FGdlbdFo9ufr4Pf2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caibBuaqe3uXgSM5jh6g459nSX4OoWuGATREUEwwva7Y1jbXXXrPN3zfmBxr//5kpe7L4dwgCloi2GVMYVuZHxKoU4KrIbxn6lgDUSxY6sXEfdRZt0VnKDtUZ5dJs7TdcYwJGeZmvtEllaEo+WLCJBWe/CHnu9VAji97WfJC48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=L1MdCpJO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1161ee54f7so4967855276.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724700609; x=1725305409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hcRvwF87oztYXFmspwLvuXVmC1FGdlbdFo9ufr4Pf2U=;
        b=L1MdCpJOr+SAZfVyN6Bw8R9asLhnPzW2fHnOV/QyaxtOj1y7Kav8gj0pQHgPoCH8bG
         3imho5EzNu4EAq/EHehBKBTfSlkioWL4jvOo4VLwoNtslIZ4jKDu8Vn7eMkD0OFvgEbz
         dAeYXJl+TxsgzEvBs+5Gn52hAW0EBcSse+++0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700609; x=1725305409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcRvwF87oztYXFmspwLvuXVmC1FGdlbdFo9ufr4Pf2U=;
        b=Ly4ZooetpamvBLAesP9RtSYQQl7eQh6Z++YDvx0P967sBDUQq7OyOQWGPOf8rQZzog
         HOLu3heQT+3krxl0bzHZumVkA9Ho096bQh+H50e/FHLEiMgYtB+fiBZEBCTOA7DBmoxg
         kaqgaU48Zkz5pymZiBySMUAJtVt3bLyayg5SK67+z0X+Z1/cKTsm/tde8L4lQHUp011e
         vrTX0V7p7XcExpuB/LS0sFxTNlJTlMo7Un4mbGoMfnXnIz5/YZ7bKazGR240R94ecY/a
         BGZ3Sw0xfyGWBRAIDmjcOBZCWYPOq1nvXqqLGLIK8tjCwSnPKlnzBa6rl4E/qIWn6j3O
         1n2w==
X-Forwarded-Encrypted: i=1; AJvYcCU+xlQ6shLin7WrIuqVwdc16qHfrUvokxfb4SjW0WHt16HlzkE/D+nEuw5xh1YcRVOtCOlskLxQFK1jDzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFC/TwKErrtmEJ2J2GIDjyciFzvX+8TYh/CkykPqQWNorSFNhp
	F+fuec9X6Eek/eh97DB6G1QMLUKpZSxKpFRZeQtlt6KYqZJ/PMQILLTJeVGDr1JFXW1rc/+2yt5
	pOQAbm9cH1kuWfAB0QZhDHVm+6LrwjhD+Hd2HPq+HXShZ6JwZ
X-Google-Smtp-Source: AGHT+IH9OKCoXZU4ZY1OpV22CH8LZbAk8o4r/ypIvORd7W0PJgSWCSqUslpmBTkJiaMOKHPlHpoLfy4bG+SLPynCflA=
X-Received: by 2002:a05:6902:dc9:b0:e13:e9ca:7bcc with SMTP id
 3f1490d57ef6-e17a8680788mr10420377276.54.1724700608979; Mon, 26 Aug 2024
 12:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823085146.4017230-1-yangyun50@huawei.com>
In-Reply-To: <20240823085146.4017230-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Aug 2024 21:29:57 +0200
Message-ID: <CAJfpegu-nd9Oa+eeNKbzqtMJOgoFHgxO3fVr=2qt_WZv2EU3-w@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix memory leak in fuse_create_open
To: yangyun <yangyun50@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 10:52, yangyun <yangyun50@huawei.com> wrote:
>
> The memory of struct fuse_file is allocated but not freed
> when get_create_ext return error.
>
> Fixes: 3e2b6fdbdc9a ("fuse: send security context of inode on file")
> Cc: stable@vger.kernel.org
> Signed-off-by: yangyun <yangyun50@huawei.com>

Thanks, applied.

Miklos

