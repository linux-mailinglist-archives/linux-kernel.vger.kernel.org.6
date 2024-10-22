Return-Path: <linux-kernel+bounces-376035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE2E9A9F09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AEE1C22B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2FE1991AB;
	Tue, 22 Oct 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="od643V/0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873722083;
	Tue, 22 Oct 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590436; cv=none; b=c4JRH/9euGnhc4tTgZK/vuaURuK/R3GjamjPRT0nws3u6xRtZ1tJcG18RVFj7JU3Y5s4MZ07hKyNBdYJtV9iyN1w7l9SfDU88E+S0bbnx7DvOSSj3tG5CjqY5x9f+AcZV/6/KNihWJhVzo2T7mQ+76xeZ+3SaQ/L2va1VRXl9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590436; c=relaxed/simple;
	bh=72aL44PRxxj8ZA9z2U3Q1aVQqTnF88Q2zuOTxBxM5Yo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AuJRo7WmLl79Abs4V818eL0JTANEXTazy+yoo/8W2mHGho5MIWMxj1/uq0rY1jADPqkht+vvBQ3z6jhgVBFPes+woko1jI75xPWABB4rLNFK2YlvVpTdAaBZoDUcfnJzDRif92tVffHJ7SbOYK2Vf5EhGMGqdQnrH7fhvm/6Bgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=od643V/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F400C4CEC3;
	Tue, 22 Oct 2024 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729590435;
	bh=72aL44PRxxj8ZA9z2U3Q1aVQqTnF88Q2zuOTxBxM5Yo=;
	h=Date:From:To:Subject:From;
	b=od643V/0dvKWlHeu9B7Pbqp4/CJvU9zV1WZVqp6cB/J6v/5CljZPXz/BEm/55RKn0
	 86/JPgeUx/w2eS8HlxETHNYPJL/DKhoBQWzhOUOHRC1rnOb/GWVccZuV4sXUyuE++d
	 N82RD9FNB4xCwf/OxD2AxvvChcDU893Jf3fQM9M4=
Date: Tue, 22 Oct 2024 11:47:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: usbutils 018 release
Message-ID: <Zxd0oZefuehqhA7z@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Pa0djRm5uaNF5vn"
Content-Disposition: inline


--0Pa0djRm5uaNF5vn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's been another year, and there have been a number of updates and
fixes for the usbutils programs and build system, so it's time for a new
release.

I'd like to announce the usbutils 018 release.

The largest change here that will only be visable to packagers is that
the build system has now moved to meson.  That way only the files in git
are in the tarballs so everyone can verify the providence of all files
in the repository (i.e. not relying on random binaries on my local
machine which is what autotools does...)

For users, the largest change will be that the '-v' option to lsusb will
now show the negoitated speed of the device on the bus, not just what
the descriptor says the device can run at, and there is better handling
for new device descriptor fields and information in the '-v' output as
well.

Full details of the changes in this are found below in the shortlog.

Tarballs can be found on kernel.org here:
	https://www.kernel.org/pub/linux/utils/usb/usbutils/

Or you can pull from the following git locations as well:
	https://git.sr.ht/~gregkh/usbutils
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usbutils.git
	https://github.com/gregkh/usbutils
	https://github.com/linux-usb/usbutils

Many thanks to Emil for help with the meson build changes, and for
integrating the project into the github build/testing infrastructure to
give people who like using github, feedback if their changes break the
build.


thanks,

greg k-h

------------

usbutils 018
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Aurelien Jarno (3):
      Add a manpage for lsusb.py
      Add lsusb.py.1 to DISTCLEANFILES
      Add a manpage for usbreset

Dominique Leuenberger (1):
      usb-devices: fix bashism

Emil Velikov (50):
      autogen.sh: use valid email for 2024 copyright
      README: list libudev as a requirement
      meson: bump to libusb-1.0.22, reinstate libusb_set_option()
      meson: set project details
      meson: always include config.h first, use -include
      meson: add compiler warnings to the build
      meson: add all* CFLAGS from travis-autogen.sh
      meson: temporary disable extra noisy warning
      man: remove version from the manual pages
      lsusb.py: remove inline lsusb-VERSION.py note
      lsusb.py: remove @DATADIR@ instance
      README: add Contributing section
      lsusb.py: mention both usb.ids paths
      Rename .in files to their final state
      Update .gitignore files
      meson: convert Wswitch-enum to Wswitch and enable
      meson: enable commented out warnings
      meson: add a bunch more warnings to the mix
      travis: remove travis-ci files
      ci: add build ci (Alpline) based on kmod's
      ci: add Arch permutation
      ci: add Debian permutation
      ci: add Fedora permutation
      ci: add Ubuntu permutation
      ci: add codeql (static analysis) based on main.yml
      ci: add SPDX copyright/licence identifiers
      README: fix link, add DCO and SPDX details
      lsusb: make internal API const-aware
      lsusb: const annotate most data, re-enable -Wdiscarded-qualifiers
      ci: run monthly checks by dependabot
      meson: fold usbhid-dump/meson.build in
      .gitmodules: remove no longer needed file
      ci: add/update the final SPDX identifiers
      man: move manual pages in designated sub-folder
      ci: add reuse lint stage
      lsusb: drop the audioterminal hash table
      lsusb: drop the videoterminal hash table
      lsusb: drop the genericstrtable hash tables
      meson: re-enable some warnings
      editorconfig: add initial config file
      .clang-format: import from Linux kernel as of v6.11.-rc6
      .clang-format: update for_each pattern and list
      ci: add clang-format action
      clang-format: bump column limit to 120
      ci: directly use archlinux:multilib-devel
      ci: drop the mkdir && cd dance
      ci: add clang permutation, for 64bit only
      lsusb: reformat and add trailing commas for multi-line arrays
      usb-spec: move the opening curly brackets to end of line
      ci: add codespell action, fix all typos

Fabien Sanglard (1):
      Include "negotiated speed" in device dump

Greg Kroah-Hartman (31):
      lsusb: remove autotools checks for iconv
      lsusb: remove byteswap.h check
      lsusb: always include config.h
      usbutils: remove usbutils.pc
      usbutils: convert build system to use meson
      usbutils.spdx: update file based on recent file movements
      lsusb: fix memory leak in libusb
      lsusb: billboard alternate mode is in little endian format
      README: update based on build tool changes
      lsusb: add support to show superspeed++
      usbhid-dump: clean up meson.build a bit
      justfile: add one
      meson: disable -Wswitch-enum
      usbutils.spdx: update the SPDX file
      README.md: update the SPDX wording a bit
      README.md: add the linux-usb mailing list to the README.
      LICENSE: add LGPL-2.1 license text
      usbutils.spdx: update the data
      update usbutils.spdx file
      editorconfig: make the line length 120
      clang-format: add proper copyright information
      clang-format: fix SPDX license
      lsusb-t: get rid of custom list.h logic
      LICENSES: add CC0 and MIT licenses
      lsusb-t: fix memory leak
      justfile: add some more targets
      usbutils.spdx: update based on file additions
      usbutils.spdx: update due to new file and checksums
      usbreset: replace some unbounded strcpy() calls
      sysfs.c: fix an theoretical issue with snprintf()
      usbutils.spdx: update checksums

Kirill Furman (1):
      usbmisc: fix possible stack-buffer-overflow Running lsusb with -D arg=
ument and path, which len is more than PATH_MAX + 1, cause stack-buffer-ove=
rflow because of copy to the buf a string without null-terminator Force set=
ting 0 byte to the end of the buf fixes this error Fix #190

Ronald (3):
      update ccid descriptor dumping to V1.1 spec
      V1.1 is actually V1.10..
      remove one space

Teresa Remmet (1):
      usb-devices: Fix usb-devices with busybox

Tomasz Mo=C5=84 (1):
      Do not warn about missing LPM bit when not required

Torleiv Sundre (1):
      lsusb: add VideoControl Endpoint Descriptor

dependabot[bot] (2):
      ci: bump github/codeql-action in the all-actions group
      ci: bump the all-actions group with 2 updates

--0Pa0djRm5uaNF5vn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAmcXdJwACgkQONu9yGCS
aT7HbA/+K5Gf96VpsIjS+oE6reeK78l7vi3LidxCUNOM03f5jM9y+jXbFjZIuv5l
0BCJNW3VbLihvQL1KEJ2TSuBkmy3r8rvyB4sw9Z4WDrEmTwnCRKyUswZhTGH32gL
97P4NggeNgYpI0lQivAi5WWQDqoEAxj21g/LzjuznFX5HfjfZ3kyzInswBwRUK7G
Uy+Kj0RbkSaYUSgiX8mKxy0NAAuT7lJZn6lYydZb82j7HwapA2LU6os/AYiq/hYp
ia+kUhI1UsBbYjfEGYC7EpgyLNkDe+QpZtiUzsD76vlfxZju/ByZ5xEDjNg6tg6b
5LIGwWjSSbjwS5lHsEjpGOw9oQvHzGc1/Re9srm47IoWDkHqdUishI9nDboNGpuR
Y52h7OHgHTyQxRHjWkj+niwz/Pk03YUANUpEzPMf5ijU0lxVBV/TBdZYN8IL1KwW
sKYCzpKIM17AHdnI9NJmKwuQb0dKsHrZhwoZ0MJa8E0MEq8eUlu9y5Ob2pfImgeB
yiNhtY7BfmSCHB2Hy/QsAh9sdfEQq5YkwvToXll9RR1GeXMrZLG9zri5oirUiIJs
hpslHxKdOjMsYOj32kZVm1XR+3cSfFe/LDKxWHA2Fneoi+eeYiQaW9w5rBjSWKBx
zYuhEKgztfBd47ABhBH8Va5GpsDk2Qo+O0+ILeFFhS3o14R2wFg=
=Xc57
-----END PGP SIGNATURE-----

--0Pa0djRm5uaNF5vn--

