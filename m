Return-Path: <linux-kernel+bounces-386034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736449B3E63
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348E2283521
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBD1EE02A;
	Mon, 28 Oct 2024 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zea4tYM9"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F21E1C05
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730157831; cv=none; b=Ve0a3V6m7gvJCYSbwCkGBHPEiUZ1fAUBMi5QJRM5Cy9kV0sYV7h3NwLq+9lK9dE6YGPFmjKq8AexRyZrdpoOIdbeqIwrGUSEHS3qW+FI9rqjgTc+WbGMaj7Q2C4qAygZYP6eZbku2VlAa4eXqmbfyrzppncj588+oyVHnyGyK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730157831; c=relaxed/simple;
	bh=2y8Wld8kncRsKF2kcLF1MVjG9QwSLhrT/+YnRDUOQM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/JBkCeD8MCQ1PeLqCL3k+gaS4T/rC2s3SIk9RZl1T6xkND5fNwosHcsJmfJm7sZ7CFsN5QEs3zV4RFHTjXfSgm5d7RlbP+tq43SembofiLUsbPSVLX/DpEy8s681ZIlwRqQWrHkiP2t6ogf3sa8Rh2DH1sA3qQJk86BUiG26Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zea4tYM9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e681ba70so6259e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730157827; x=1730762627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1zLuo0XC+XyyU+1UeAGiD6DsUYvZskyQ0u/pcuHjoM=;
        b=zea4tYM9/eQ7Npf9GYiO0d1bFixO+LFbAqJQuQkJCFNxna2gbdIdIbCzlk6yKkPNpO
         0UdTGZAvvW9pWtHNeD7sZ2kF9CZpkzvngElZIt84aPaut2VyG8CVHhpeiPY3WJg/8IaS
         UqF72J4LnfRrd76gjJuFeKLn2xMVyCWQY97SgDbU2cybYSp3tUqdWLIZXCXPkKfch/5K
         tIY/PTZcMG7DLkNfapfWWeIoV2a6cfWDWBGG6WvmfmEy8I4KSpPF0TEvFR5CvS8Mwvyu
         CfaXDkwZ3OY39pvk5eT+u15iIwsRa0PZreEcO6xl1szXr1Zk59TEujxOL7RYfS8MJJhA
         CPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730157827; x=1730762627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1zLuo0XC+XyyU+1UeAGiD6DsUYvZskyQ0u/pcuHjoM=;
        b=JmUreDyWeF2Oji6z1PGzfbno+NP0u6Mew1UpYD9jMNp3BfXGTYlupt4O4fSG3UMk3I
         F+6PykLFgYuuWKFJtV3+HRRkkFP70hnkJXzxCN9hS1cjy33mFIx4JMIv3xVRXonKJdz7
         dJu8EFBCBr58gDezIAD/tUd0XH2ywL6cSxLPdn1b5o+SMAf8B8uks/PlQh55b8C6Ux2c
         82g8rcxqft8DhYWLv1dnVaRGwvREssAcW7Lja7wqMGLDZrMRoux8tXFp5oC2aLDIgQ6J
         wV+aNT/JMKts6H9CpYF7H/jxMrDoTF4RRV83qogdWGVoZdwsbip/LcCr+MikKyG3Vf7j
         O/uA==
X-Forwarded-Encrypted: i=1; AJvYcCWmvs6xwrMSWGjHHU+KS8cr5s0LM1YvOsBX6fO2Je8O3d13CTgB2aLzjOFLvKEt8CoQhxgg4d0KO4fQkLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsKtrx0E/d+sHEZsJysnQqAGRvnDt6reLBw7cHJCXwLjLh/RO
	Xm9zMFpVSfn6sTLfjueMznkEyr4F5fMS6TzlMeNVTzVmylKZXnuK8bHh3FWZTEeA4+ojeNxMhiK
	bi0nP+hPILTblqKo9ukY666Jw08ZDQqBi28Ko
X-Gm-Gg: ASbGncvclj7Ep4ZIpL6P6JiN2z7kDOBg2YsFNBcBk0B1o0sZjJSVnHBkEy0Ueeujo2e
	ILopL1XoM5J+BD8dp0Stlsx5QuF8Xfavx8m72d2PNa2StAbOtsoTDVddL6lc+fA==
X-Google-Smtp-Source: AGHT+IEw7iNwQ2e8madGqWDXhgztbgFcMKXV7oI5e4FPMEUVgwXAgCN5telSrPHpmMDsyb9a4XxiOhjigX7nQfXvJD4=
X-Received: by 2002:a05:6512:138c:b0:539:d0c4:5b53 with SMTP id
 2adb3069b0e04-53b480a3611mr184188e87.4.1730157826478; Mon, 28 Oct 2024
 16:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028214550.2099923-1-kaleshsingh@google.com>
 <20241028214550.2099923-3-kaleshsingh@google.com> <20241028191448.5f62531a@rorschach.local.home>
In-Reply-To: <20241028191448.5f62531a@rorschach.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 28 Oct 2024 16:23:33 -0700
Message-ID: <CAC_TJvf8aU07JRiBK9tgWynixXBX9MpqFJh6GVaUcEzqX6aLhQ@mail.gmail.com>
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

On Mon, Oct 28, 2024 at 4:14=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 28 Oct 2024 14:43:58 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > Add test to check the tracefs gid mount option is applied correctly
> >
> >    ./ftracetest test.d/00basic/mount_options.tc
> >
> > Use the new readme string "[gid=3D<gid>] as a requirement and also upda=
te
> > test_ownership.tc requirements to use this.
> >
> > mount_options.tc will fail currently, this is fixed by the subsequent
> > patch in this series.
>
> Test cases should never be added when they can fail. They should always
> come after the fix is applied. But it appears that you check the README
> to make sure that it does work and not fail.
>
> I'll take a look at these patches in more detail later.

Hi Steve,

Thank you for the quick reviews, please feel free to ignore until you are b=
ack.

I'll address these comments and resend a v2.

Thanks,
Kalesh

>
> Thanks,
>
> -- Steve
>
>
> >
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++++
> >  .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
> >  .../testing/selftests/ftrace/test.d/functions |  25 +++++
> >  3 files changed, 129 insertions(+), 13 deletions(-)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount=
_options.tc
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_option=
s.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
> > new file mode 100644
> > index 000000000000..b8aff85ec259
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
> > @@ -0,0 +1,101 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Test tracefs GID mount option
> > +# requires: "[gid=3D<gid>]":README
> > +
> > +fail() {
> > +     local msg=3D"$1"
> > +
> > +     echo "FAILED: $msg"
> > +     exit_fail
> > +}
> > +
> > +find_alternate_gid() {
> > +     local original_gid=3D"$1"
> > +     tac /etc/group | grep -v ":$original_gid:" | head -1 | cut -d: -f=
3
> > +}
> > +
> > +mount_tracefs_with_options() {
> > +     local mount_point=3D"$1"
> > +     local options=3D"$2"
> > +
> > +     mount -t tracefs -o "$options" nodev "$mount_point"
> > +
> > +     setup
> > +}
> > +
> > +unmount_tracefs() {
> > +     local mount_point=3D"$1"
> > +
> > +     # Need to make sure the mount isn't busy so that we can umount it
> > +     (cd $mount_point; finish_ftrace;)
> > +
> > +     cleanup
> > +}
> > +
> > +create_instance() {
> > +     local mount_point=3D"$1"
> > +     local instance=3D"$mount_point/instances/$(mktemp -u test-XXXXXX)=
"
> > +
> > +     mkdir "$instance"
> > +     echo "$instance"
> > +}
> > +
> > +remove_instance() {
> > +     local instance=3D"$1"
> > +
> > +     rmdir "$instance"
> > +}
> > +
> > +check_gid() {
> > +     local mount_point=3D"$1"
> > +     local expected_gid=3D"$2"
> > +
> > +     echo "Checking permission group ..."
> > +
> > +     cd "$mount_point"
> > +
> > +     for file in "." "events" "events/sched" "events/sched/sched_switc=
h" "events/sched/sched_switch/enable"; do
> > +             local gid=3D`stat -c "%g" $file`
> > +             if [ "$gid" -ne "$expected_gid" ]; then
> > +                     cd - # Return to the previous working direcotry (=
tracefs root)
> > +                     fail "$(realpath $file): Expected group $expected=
_gid; Got group $gid"
> > +             fi
> > +     done
> > +
> > +     cd - # Return to the previous working direcotry (tracefs root)
> > +}
> > +
> > +test_gid_mount_option() {
> > +     local mount_point=3D$(get_mount_point)
> > +     local mount_options=3D$(get_mnt_options "$mount_point")
> > +     local original_group=3D$(stat -c "%g" .)
> > +     local other_group=3D$(find_alternate_gid "$original_group")
> > +
> > +     # Set up mount options with new GID for testing
> > +     local new_options=3D`echo "$mount_options" | sed -e "s/gid=3D[0-9=
]*/gid=3D$other_group/"`
> > +     if [ "$new_options" =3D "$mount_options" ]; then
> > +             new_options=3D"$mount_options,gid=3D$other_group"
> > +             mount_options=3D"$mount_options,gid=3D$original_group"
> > +     fi
> > +
> > +     # Unmount existing tracefs instance and mount with new GID
> > +     unmount_tracefs "$mount_point"
> > +     mount_tracefs_with_options "$mount_point" "$new_options"
> > +
> > +     check_gid "$mount_point" "$other_group"
> > +
> > +     # Check that files created after the mount inherit the GID
> > +     local instance=3D$(create_instance "$mount_point")
> > +     check_gid "$instance" "$other_group"
> > +     remove_instance "$instance"
> > +
> > +     # Unmount and remount with the original GID
> > +     unmount_tracefs "$mount_point"
> > +     mount_tracefs_with_options "$mount_point" "$mount_options"
> > +     check_gid "$mount_point" "$original_group"
> > +}
> > +
> > +test_gid_mount_option
> > +
> > +exit 0
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownersh=
ip.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > index 094419e190c2..e71cc3ad0bdf 100644
> > --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > @@ -1,24 +1,14 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0
> >  # description: Test file and directory ownership changes for eventfs
> > +# requires: "[gid=3D<gid>]":README
> >
> >  original_group=3D`stat -c "%g" .`
> >  original_owner=3D`stat -c "%u" .`
> >
> > -mount_point=3D`stat -c '%m' .`
> > +local mount_point=3D$(get_mount_point)
> >
> > -# If stat -c '%m' does not work (e.g. busybox) or failed, try to use t=
he
> > -# current working directory (which should be a tracefs) as the mount p=
oint.
> > -if [ ! -d "$mount_point" ]; then
> > -     if mount | grep -qw $PWD ; then
> > -             mount_point=3D$PWD
> > -     else
> > -             # If PWD doesn't work, that is an environmental problem.
> > -             exit_unresolved
> > -     fi
> > -fi
> > -
> > -mount_options=3D`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).*/=
\1/'`
> > +mount_options=3D$(get_mnt_options "$mount_point")
> >
> >  # find another owner and group that is not the original
> >  other_group=3D`tac /etc/group | grep -v ":$original_group:" | head -1 =
| cut -d: -f3`
> > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/te=
sting/selftests/ftrace/test.d/functions
> > index 779f3e62ec90..84d6a9c7ad67 100644
> > --- a/tools/testing/selftests/ftrace/test.d/functions
> > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > @@ -193,3 +193,28 @@ ftrace_errlog_check() { # err-prefix command-with-=
error-pos-by-^ command-file
> >      # "  Command: " and "^\n" =3D> 13
> >      test $(expr 13 + $pos) -eq $N
> >  }
> > +
> > +# Helper to get the tracefs mount point
> > +get_mount_point() {
> > +     local mount_point=3D`stat -c '%m' .`
> > +
> > +     # If stat -c '%m' does not work (e.g. busybox) or failed, try to =
use the
> > +     # current working directory (which should be a tracefs) as the mo=
unt point.
> > +     if [ ! -d "$mount_point" ]; then
> > +             if mount | grep -qw "$PWD"; then
> > +                     mount_point=3D$PWD
> > +             else
> > +                     # If PWD doesn't work, that is an environmental p=
roblem.
> > +                     exit_unresolved
> > +             fi
> > +     fi
> > +     echo "$mount_point"
> > +}
> > +
> > +# Helper function to retrieve mount options for a given mount point
> > +get_mnt_options() {
> > +     local mnt_point=3D"$1"
> > +     local opts=3D$(mount | grep -m1 "$mnt_point" | sed -e 's/.*(\(.*\=
)).*/\1/')
> > +
> > +     echo "$opts"
> > +}
> > \ No newline at end of file
>

