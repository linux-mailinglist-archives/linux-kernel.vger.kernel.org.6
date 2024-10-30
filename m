Return-Path: <linux-kernel+bounces-389285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9819B6AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EB7281294
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99181BD9CB;
	Wed, 30 Oct 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPJ3rFsE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636113FEE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309066; cv=none; b=IIY0zz0g7GG86gaBX1AYGgtYoFrD4QvFelUx+6+D61OxPXb8f3YHUvHTqTjwJVrJOt9ZKevu1CFIdP2DWfIf4YPDkXBhgef0+vWQ14HX/YjF6Yjazx3q4Hb9h08XkS8lGdxcd2IjTI9pCGnUI5i6ET6NPWe65wZpcz1JuOOlL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309066; c=relaxed/simple;
	bh=WviN9txN0CrQa1oy/crkHmncmo1YuKYTJThTJDUFEkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRAzvNVmcb/9kX2fEDWxzkiN6NSPvRzjCbjo+y3vMnhlPTVmno6PsSOTFi5QufuoGpUJSpwV1vCNJEvIKCza460bQfvSAN+h3WthAVKlVOzW4pip9Md3FMCRY2sl/SuxdAq/iSe7t6/xKG3z0bA+bmNs5QhnQYSw1KbVgh7MkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPJ3rFsE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso15065e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730309061; x=1730913861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOcAWHV5P+ZBR3oghxDNAmcIDt1HA6ow1slX+W8r2xI=;
        b=DPJ3rFsEIM7pZ31SmqyAy7+8H3hSwJcJgVIJyAs/GSCTIPfpRZvVNr1nkrvUNo2cwA
         DaT3FVzjuYYgrNhOR1+llMAcvpOiQMzpftG5wV4nPocoP54t0LNRgEiKVrMalVd01uZ+
         1joF/KZqcgtbWYJaY5jc0Kg+DreKnmc/u6qoda7j8ch4yqOSQz0IaB3ldS45P7aT4uX5
         LIKQR7EN+jOtUC8K4uhACM6YiOQ9iEvERhKjgLmb/IvzJY3e/ij8M5s9Hhpb1lgEjiX8
         qu/X4L6YvW0fntWr85hRLLguckci4LBXze41Mx4B9VCtkLROlo4+QVZkwRQqe01gc+cp
         qZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309061; x=1730913861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOcAWHV5P+ZBR3oghxDNAmcIDt1HA6ow1slX+W8r2xI=;
        b=b4R6iGJB11P5yol/gJ/LCuOC1G/0Tf9u9NOs8NiqFBhpTgzXmifKUB07f59lV+aFXW
         fZO6qn2RuJVSO1L7VQblmV5KVKFEgiKsbdEGxJ7zGn+HYtA7Cb1qVEQQ1Zn+V74eSbmx
         a0rtkHyK7eQzeeL+62wOOsf42w73r0fklrceZKfXrkLmwe+qB5b74WJ0jSck8zezSpmf
         rKuTNL2HUXzFMuwIXYakMivWWZV6fegLddhfowlotZMGAYdKVKEKh7KpK0Nc+LRMeVgx
         L8JaKVxLbsOTaKRoKQ/m/n4SSCfrAMd99B/KoBovBtyLTVzdqdZrAxCCVM4cQANaV5FF
         QMGg==
X-Forwarded-Encrypted: i=1; AJvYcCULOfifGhf66IRJovhSsmj1cjIYe7rFOCz+m5O+gAv0nH3j6geplivAn/QrGyVlHVJ9oftJksvXTnsK+Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmRaWB2qK/CTuB3GmwQXdWNjZ21QmMyXDMiLRDqzf7O2Y+/Iy
	I81xhCaYrQyE6Mnrp7zs6iQMFYXQ519fEZrDUrZJVU6irNwp0NB8ZlrFnDxzyip9q427EEXqsOa
	jAK1CrOrGfVMjWHPDqtywn/ljdEr69QQQsu+q
X-Gm-Gg: ASbGncuk8oLiO/I6C3+HP2IsFRQvH3C4SM1JIZcb3W3jxU3l+iORXFzvOUNU3zZArxw
	Zvc+mj+WYh5Dvaz+cm1QLF7pQAqxzHkFFvW1LLGYjjYYZSu4hQSQ5Y0PfO5rW7w==
X-Google-Smtp-Source: AGHT+IG/KI4bV1Y+XgKIRsw188s6cXrD+X8g2TljCfLmP7yyw6XvY1UQhIxzR9TJhdr8DvUIQOSUc5CNOtoD7VsnUZw=
X-Received: by 2002:a05:600c:4e0f:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-431b4a3d374mr10684965e9.7.1730309059952; Wed, 30 Oct 2024
 10:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028214550.2099923-1-kaleshsingh@google.com>
 <20241028214550.2099923-3-kaleshsingh@google.com> <20241028191448.5f62531a@rorschach.local.home>
 <CAC_TJvf8aU07JRiBK9tgWynixXBX9MpqFJh6GVaUcEzqX6aLhQ@mail.gmail.com>
In-Reply-To: <CAC_TJvf8aU07JRiBK9tgWynixXBX9MpqFJh6GVaUcEzqX6aLhQ@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 30 Oct 2024 10:24:07 -0700
Message-ID: <CAC_TJvf_sOfP5R4VG+JExc4J3dUbcMVVoRqvO1S8QXYiK4oFZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] tracing/selftests: Add tracefs mount options test
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dhowells@redhat.com, mhiramat@kernel.org, surenb@google.com, 
	jyescas@google.com, kernel-team@android.com, android-mm@google.com, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Eric Sandeen <sandeen@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:23=E2=80=AFPM Kalesh Singh <kaleshsingh@google.co=
m> wrote:
>
> On Mon, Oct 28, 2024 at 4:14=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Mon, 28 Oct 2024 14:43:58 -0700
> > Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > > Add test to check the tracefs gid mount option is applied correctly
> > >
> > >    ./ftracetest test.d/00basic/mount_options.tc
> > >
> > > Use the new readme string "[gid=3D<gid>] as a requirement and also up=
date
> > > test_ownership.tc requirements to use this.
> > >
> > > mount_options.tc will fail currently, this is fixed by the subsequent
> > > patch in this series.
> >
> > Test cases should never be added when they can fail. They should always
> > come after the fix is applied. But it appears that you check the README
> > to make sure that it does work and not fail.
> >
> > I'll take a look at these patches in more detail later.
>
> Hi Steve,
>
> Thank you for the quick reviews, please feel free to ignore until you are=
 back.
>
> I'll address these comments and resend a v2.

I've posted v2 at:
https://lore.kernel.org/r/20241030171928.4168869-1-kaleshsingh@google.com/

Thanks,
Kalesh

>
> Thanks,
> Kalesh
>
> >
> > Thanks,
> >
> > -- Steve
> >
> >
> > >
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > ---
> > >  .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++=
++
> > >  .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
> > >  .../testing/selftests/ftrace/test.d/functions |  25 +++++
> > >  3 files changed, 129 insertions(+), 13 deletions(-)
> > >  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mou=
nt_options.tc
> > >
> > > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_opti=
ons.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
> > > new file mode 100644
> > > index 000000000000..b8aff85ec259
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
> > > @@ -0,0 +1,101 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# description: Test tracefs GID mount option
> > > +# requires: "[gid=3D<gid>]":README
> > > +
> > > +fail() {
> > > +     local msg=3D"$1"
> > > +
> > > +     echo "FAILED: $msg"
> > > +     exit_fail
> > > +}
> > > +
> > > +find_alternate_gid() {
> > > +     local original_gid=3D"$1"
> > > +     tac /etc/group | grep -v ":$original_gid:" | head -1 | cut -d: =
-f3
> > > +}
> > > +
> > > +mount_tracefs_with_options() {
> > > +     local mount_point=3D"$1"
> > > +     local options=3D"$2"
> > > +
> > > +     mount -t tracefs -o "$options" nodev "$mount_point"
> > > +
> > > +     setup
> > > +}
> > > +
> > > +unmount_tracefs() {
> > > +     local mount_point=3D"$1"
> > > +
> > > +     # Need to make sure the mount isn't busy so that we can umount =
it
> > > +     (cd $mount_point; finish_ftrace;)
> > > +
> > > +     cleanup
> > > +}
> > > +
> > > +create_instance() {
> > > +     local mount_point=3D"$1"
> > > +     local instance=3D"$mount_point/instances/$(mktemp -u test-XXXXX=
X)"
> > > +
> > > +     mkdir "$instance"
> > > +     echo "$instance"
> > > +}
> > > +
> > > +remove_instance() {
> > > +     local instance=3D"$1"
> > > +
> > > +     rmdir "$instance"
> > > +}
> > > +
> > > +check_gid() {
> > > +     local mount_point=3D"$1"
> > > +     local expected_gid=3D"$2"
> > > +
> > > +     echo "Checking permission group ..."
> > > +
> > > +     cd "$mount_point"
> > > +
> > > +     for file in "." "events" "events/sched" "events/sched/sched_swi=
tch" "events/sched/sched_switch/enable"; do
> > > +             local gid=3D`stat -c "%g" $file`
> > > +             if [ "$gid" -ne "$expected_gid" ]; then
> > > +                     cd - # Return to the previous working direcotry=
 (tracefs root)
> > > +                     fail "$(realpath $file): Expected group $expect=
ed_gid; Got group $gid"
> > > +             fi
> > > +     done
> > > +
> > > +     cd - # Return to the previous working direcotry (tracefs root)
> > > +}
> > > +
> > > +test_gid_mount_option() {
> > > +     local mount_point=3D$(get_mount_point)
> > > +     local mount_options=3D$(get_mnt_options "$mount_point")
> > > +     local original_group=3D$(stat -c "%g" .)
> > > +     local other_group=3D$(find_alternate_gid "$original_group")
> > > +
> > > +     # Set up mount options with new GID for testing
> > > +     local new_options=3D`echo "$mount_options" | sed -e "s/gid=3D[0=
-9]*/gid=3D$other_group/"`
> > > +     if [ "$new_options" =3D "$mount_options" ]; then
> > > +             new_options=3D"$mount_options,gid=3D$other_group"
> > > +             mount_options=3D"$mount_options,gid=3D$original_group"
> > > +     fi
> > > +
> > > +     # Unmount existing tracefs instance and mount with new GID
> > > +     unmount_tracefs "$mount_point"
> > > +     mount_tracefs_with_options "$mount_point" "$new_options"
> > > +
> > > +     check_gid "$mount_point" "$other_group"
> > > +
> > > +     # Check that files created after the mount inherit the GID
> > > +     local instance=3D$(create_instance "$mount_point")
> > > +     check_gid "$instance" "$other_group"
> > > +     remove_instance "$instance"
> > > +
> > > +     # Unmount and remount with the original GID
> > > +     unmount_tracefs "$mount_point"
> > > +     mount_tracefs_with_options "$mount_point" "$mount_options"
> > > +     check_gid "$mount_point" "$original_group"
> > > +}
> > > +
> > > +test_gid_mount_option
> > > +
> > > +exit 0
> > > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_owner=
ship.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > > index 094419e190c2..e71cc3ad0bdf 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > > +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > > @@ -1,24 +1,14 @@
> > >  #!/bin/sh
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  # description: Test file and directory ownership changes for eventfs
> > > +# requires: "[gid=3D<gid>]":README
> > >
> > >  original_group=3D`stat -c "%g" .`
> > >  original_owner=3D`stat -c "%u" .`
> > >
> > > -mount_point=3D`stat -c '%m' .`
> > > +local mount_point=3D$(get_mount_point)
> > >
> > > -# If stat -c '%m' does not work (e.g. busybox) or failed, try to use=
 the
> > > -# current working directory (which should be a tracefs) as the mount=
 point.
> > > -if [ ! -d "$mount_point" ]; then
> > > -     if mount | grep -qw $PWD ; then
> > > -             mount_point=3D$PWD
> > > -     else
> > > -             # If PWD doesn't work, that is an environmental problem=
.
> > > -             exit_unresolved
> > > -     fi
> > > -fi
> > > -
> > > -mount_options=3D`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).=
*/\1/'`
> > > +mount_options=3D$(get_mnt_options "$mount_point")
> > >
> > >  # find another owner and group that is not the original
> > >  other_group=3D`tac /etc/group | grep -v ":$original_group:" | head -=
1 | cut -d: -f3`
> > > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/=
testing/selftests/ftrace/test.d/functions
> > > index 779f3e62ec90..84d6a9c7ad67 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/functions
> > > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > > @@ -193,3 +193,28 @@ ftrace_errlog_check() { # err-prefix command-wit=
h-error-pos-by-^ command-file
> > >      # "  Command: " and "^\n" =3D> 13
> > >      test $(expr 13 + $pos) -eq $N
> > >  }
> > > +
> > > +# Helper to get the tracefs mount point
> > > +get_mount_point() {
> > > +     local mount_point=3D`stat -c '%m' .`
> > > +
> > > +     # If stat -c '%m' does not work (e.g. busybox) or failed, try t=
o use the
> > > +     # current working directory (which should be a tracefs) as the =
mount point.
> > > +     if [ ! -d "$mount_point" ]; then
> > > +             if mount | grep -qw "$PWD"; then
> > > +                     mount_point=3D$PWD
> > > +             else
> > > +                     # If PWD doesn't work, that is an environmental=
 problem.
> > > +                     exit_unresolved
> > > +             fi
> > > +     fi
> > > +     echo "$mount_point"
> > > +}
> > > +
> > > +# Helper function to retrieve mount options for a given mount point
> > > +get_mnt_options() {
> > > +     local mnt_point=3D"$1"
> > > +     local opts=3D$(mount | grep -m1 "$mnt_point" | sed -e 's/.*(\(.=
*\)).*/\1/')
> > > +
> > > +     echo "$opts"
> > > +}
> > > \ No newline at end of file
> >

