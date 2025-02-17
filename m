Return-Path: <linux-kernel+bounces-518376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ADAA38E29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9021218915DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7D1A841E;
	Mon, 17 Feb 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgHnbGEO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD61A8F7A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827979; cv=none; b=WCMw14xhNOcNvMo7PguPmVURNrIRjo08ka0zOzATKIPyd1PEkwzCjBL8oSK5P8I+WF4iC4DUO+PMRVyybL0bcs8yFp8eiNarsU+MoWAu/Zk0HBgxWoVd9YsgQyvuFBISMtZvUQSZME8wWcLFXajylwzMBu5ExqPWUnULe+QCkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827979; c=relaxed/simple;
	bh=UxRYE+GnMEXy65wJRre9vuUKgKVVkSZiKNCcZ0lZ9aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSBgiWFjpkodep8bgmnha9tkyQujED1PZ2a0n8wE2+yA8YDmVwSpHyfrL5rTgsdKwAQIkHXzaW2N9F42gqQVGmPFEsZxP3WXDliCdO3723jnbUvyYcvGuvNNriYFzi1xgjhyPF+ryWzCW7pfQGg4PyzepHUV92cO7d+6iKa2u5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgHnbGEO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739827976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wjr6J6DOeZeSoS3UpK+LIJot/A4kSVDwCJKjvWd8g2s=;
	b=cgHnbGEOVvrF8+ZNs7cQbOMGcwQkJUPTRIfKLqQoK8MtHPfL7Mt3/ePW1D+O6uqB8jDXzK
	x644pcmruSz+3b1hAz9KhG6hVR47IxH/GJL0H8nQ03A+nrdmSDpJruzXUyUMjXaYXHHckL
	AJbklXAtp86LbEk9xwAbT8uSDCcnnfU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-cCNHhSaNPtSSserz9uWFHg-1; Mon, 17 Feb 2025 16:32:55 -0500
X-MC-Unique: cCNHhSaNPtSSserz9uWFHg-1
X-Mimecast-MFC-AGG-ID: cCNHhSaNPtSSserz9uWFHg_1739827975
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f46924f63eso74992017b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739827975; x=1740432775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wjr6J6DOeZeSoS3UpK+LIJot/A4kSVDwCJKjvWd8g2s=;
        b=vx0Dg3Y3ySHOf8ZTkIaai9NknM0tXTPuSn5H+LiJA/Ava2z2pB7viXY381iO7pnjAV
         aXzvExDRd6hN0zipM3vXk0GPgHI8kiI5i5gwjYuAqwFfWgKw/4agLDDTKiFfLDhpZ/+w
         WZwqRC3XWyBajUevoaPPFoVxBPNlKy8v6BbaUVIsb7zedncqZt1Z5RA0E4mtr4LqaPox
         i+zrVNDRjCasSQLcCS9wwCB20QZH79NxTIMT2J5AUBvgRpSPp1oeOC9qJaQ04Fw8zQ/v
         uTxGUkrci0BQ2VlyeLVsYtW5ozMMeuQHUbHZ5WlhQUSZksKTFBgEvjDWQWrgladGEZnj
         Uvtw==
X-Forwarded-Encrypted: i=1; AJvYcCUx8jFkKQpD0lQkNc61RSudbllFEztb6B0UFs7+r5WPtV2HZhnMtYot/RcIkF9vVXhTISmatnDeStnDdgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWmvCAolLK0/o94yN4ovzdPFhoKp+hVuT86QPkf4jzmTGHj/a
	g4/oIXJpvryi9NYgri3J9FQBczZkrmPau/tlkmlGm2tNe2sPANXEBCnmYOGCaANgqQ4xqqWGbF3
	wFbzZ0AVKKjg1zPbwTOXKYyy+j6qKw2JpypC+u+GRhUI6osctJzZw4iQXKZkJHNewKF0mlforz/
	SYwoU2BHfZrq/1omZ+7YtxkoMLAmDhXIYfHsU/
X-Gm-Gg: ASbGncup4JvH1e5D4O+R2kzaXZPAhLT2I3upu789SS6sBmDVf1cY0K7JBk96kVYNgKy
	DglGuzpPjeGzP2byH7hQRFHtUoHUkMaxLprV0Hxtv+wUXNNsJHQ2ITXQ+0+ZA6UY4OPwQWNZ78f
	8=
X-Received: by 2002:a05:6902:2102:b0:e5b:45eb:dbfd with SMTP id 3f1490d57ef6-e5daa4c6821mr16623488276.11.1739827975046;
        Mon, 17 Feb 2025 13:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOkZYdxA7+HLOKnLODZz3B+t380yGAD+5tVKQqEu4d65LXrhAQ59NLa24+U3g/GCY/e81Og/sTryAx1QenBGY=
X-Received: by 2002:a05:6902:2102:b0:e5b:45eb:dbfd with SMTP id
 3f1490d57ef6-e5daa4c6821mr16623479276.11.1739827974804; Mon, 17 Feb 2025
 13:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-kselftest-mm-no-hugepages-v1-0-44702f538522@kernel.org> <20250212-kselftest-mm-no-hugepages-v1-1-44702f538522@kernel.org>
In-Reply-To: <20250212-kselftest-mm-no-hugepages-v1-1-44702f538522@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 14:32:29 -0700
X-Gm-Features: AWEUYZmwEXuqxVjY66-BVM_Ib4FZYHb37Giao24vLwf7Z76BXTlSrlgRvS3mTD8
Message-ID: <CAA1CXcDL+WNnn57dDQSLVkHNr46hJZf2PPTO-1zgesc1j2uxTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/mm: Fix check for running THP tests
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:52=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> When testing if we should try to compact memory or drop caches before we
> run the THP or HugeTLB tests we use | as an or operator. This doesn't wor=
k
> since run_vmtests.sh is written in shell where this is used to pipe the
> output of the first argument into the second. Instead use the shell's -o
> operator.
>
> Fixes: b433ffa8dbac ("selftests: mm: perform some system cleanup before u=
sing hugepages")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Ah I meant to use || which i believe also works in shell. Thanks for the fi=
x!

Reviewed-by: Nico Pache <npache@redhat.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index 333c468c26991421cd8f9ce6d995f9b64b0643c7..da7e266681031d2772fb0c413=
9648904a18e0bf9 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -220,7 +220,7 @@ run_test() {
>         if test_selected ${CATEGORY}; then
>                 # On memory constrainted systems some tests can fail to a=
llocate hugepages.
>                 # perform some cleanup before the test for a higher succe=
ss rate.
> -               if [ ${CATEGORY} =3D=3D "thp" ] | [ ${CATEGORY} =3D=3D "h=
ugetlb" ]; then
> +               if [ ${CATEGORY} =3D=3D "thp" -o ${CATEGORY} =3D=3D "huge=
tlb" ]; then
>                         echo 3 > /proc/sys/vm/drop_caches
>                         sleep 2
>                         echo 1 > /proc/sys/vm/compact_memory
>
> --
> 2.39.5
>


