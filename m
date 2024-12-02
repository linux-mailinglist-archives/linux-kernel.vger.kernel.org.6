Return-Path: <linux-kernel+bounces-426802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76829DF896
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8985D162142
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 01:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D432E555;
	Mon,  2 Dec 2024 01:34:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226F257D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733103255; cv=none; b=EcoA1W2Gs9/jT6TfXz1JvfKmr1KinLlzBFddZmvPpRIFc5nuCMcuBl7a7JXa6NrIBpXp1QLmnw3NVJOypEg3y9XElLhm5YCEEq9zUjT7Ynl/PtXstRKgA+3JWlnTLlyYeFCly0Ic3tymIX/Vunjzu28BRjQ5IWFgVlYIuBU311k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733103255; c=relaxed/simple;
	bh=v6NROj98Vt+JIRGzm0rhzypGFT/dMaASTdyeGqf+F30=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=euyPPJ+OofFQ28UkOUgb6NbRtfG/s94v7YsKstICdDasl1V0EcGCKidGGIAazOPd92ySPpRtK1l/4He5JGdzXbfMEV6AE7E9TVw8PXkJntPEmnOKIiuo8SRDzaPeV26oyvi+faNwWaeQc+2Ps/lGk28Xm5cb+YHVKpGyOICSgss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8C0C4CECF;
	Mon,  2 Dec 2024 01:34:13 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------ynBQ5orTojtKmtqZQOw1ViC4"
Message-ID: <7bb57485-c08c-4121-ade5-8c76bc48e615@linux-m68k.org>
Date: Mon, 2 Dec 2024 11:34:11 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: use kernel's generic muldi3 libgcc function
From: Greg Ungerer <gerg@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, arnd@arndb.de
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20231113133209.1367286-1-gerg@linux-m68k.org>
 <CAMuHMdVZh6-64hfx1jgOijBEG6cTftinqf+4fZvqjJtV1hO95g@mail.gmail.com>
 <1dd8be4b-d5c3-4074-a91e-3ce998ce3050@linux-m68k.org>
Content-Language: en-US
In-Reply-To: <1dd8be4b-d5c3-4074-a91e-3ce998ce3050@linux-m68k.org>

This is a multi-part message in MIME format.
--------------ynBQ5orTojtKmtqZQOw1ViC4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Arnd, ping...


On 6/11/24 08:04, Greg Ungerer wrote:
> Hi Geert,
> 
> On 5/11/24 21:46, Geert Uytterhoeven wrote:
>> Hi Greg, Arnd,
>>
>> On Mon, Nov 13, 2023 at 2:32 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>>> Use the kernels own generic lib/muldi3.c implementation of muldi3 for
>>> 68K machines. Some 68K CPUs support 64bit multiplies so move the arch
>>> specific umul_ppmm() macro into a header file that is included by
>>> lib/muldi3.c. That way it can take advantage of the single instruction
>>> when available.
>>>
>>> There does not appear to be any existing mechanism for the generic
>>> lib/muldi3.c code to pick up an external arch definition of umul_ppmm().
>>> Create an arch specific libgcc.h that can optionally be included by
>>> the system include/linux/libgcc.h to allow for this.
>>>
>>> Somewhat oddly there is also a similar definition of umul_ppmm() in
>>> the non-architecture code in lib/crypto/mpi/longlong.h for a wide range
>>> or machines. Its presence ends up complicating the include setup and
>>> means not being able to use something like compiler.h instead. Actually
>>> there is a few other defines of umul_ppmm() macros spread around in
>>> various architectures, but not directly usable for the m68k case.
>>>
>>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>>>   arch/Kconfig                   |  8 +++
>>>   arch/m68k/Kconfig              |  2 +
>>>   arch/m68k/include/asm/libgcc.h | 20 +++++++
>>>   arch/m68k/lib/Makefile         |  2 +-
>>>   arch/m68k/lib/muldi3.c         | 97 ----------------------------------
>>>   include/linux/libgcc.h         |  4 ++
>>>   6 files changed, 35 insertions(+), 98 deletions(-)
>>>   create mode 100644 arch/m68k/include/asm/libgcc.h
>>>   delete mode 100644 arch/m68k/lib/muldi3.c
>>
>> I had this in my local tree for about a year.
>> Is it fine to queue this in the m68k tree, or does this need a broader
>> coverage?
> 
> I am still in favor of it :-)
> Would be good to get some feedback on the common code changes, like the change
> to libgcc.h.
> 
> Regards
> Greg
> 
> 
--------------ynBQ5orTojtKmtqZQOw1ViC4
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-m68k-use-kernel-s-generic-muldi3-libgcc-function.patch"
Content-Disposition: attachment;
 filename*0="0001-m68k-use-kernel-s-generic-muldi3-libgcc-function.patch"
Content-Transfer-Encoding: base64

RnJvbSAxZmUzYWE0MmU0MmZjNzNiOWNlODc1NDUxNjY5OWIxYmU3YWVjN2JiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBHcmVnIFVuZ2VyZXIgPGdlcmdAbGludXgtbTY4ay5v
cmc+CkRhdGU6IE1vbiwgMTMgTm92IDIwMjMgMTM6NTk6NTAgKzEwMDAKU3ViamVjdDogW1BB
VENIXSBtNjhrOiB1c2Uga2VybmVsJ3MgZ2VuZXJpYyBtdWxkaTMgbGliZ2NjIGZ1bmN0aW9u
CgpVc2UgdGhlIGtlcm5lbHMgb3duIGdlbmVyaWMgbGliL211bGRpMy5jIGltcGxlbWVudGF0
aW9uIG9mIG11bGRpMyBmb3IKNjhLIG1hY2hpbmVzLiBTb21lIDY4SyBDUFVzIHN1cHBvcnQg
NjRiaXQgbXVsdGlwbGllcyBzbyBtb3ZlIHRoZSBhcmNoCnNwZWNpZmljIHVtdWxfcHBtbSgp
IG1hY3JvIGludG8gYSBoZWFkZXIgZmlsZSB0aGF0IGlzIGluY2x1ZGVkIGJ5CmxpYi9tdWxk
aTMuYy4gVGhhdCB3YXkgaXQgY2FuIHRha2UgYWR2YW50YWdlIG9mIHRoZSBzaW5nbGUgaW5z
dHJ1Y3Rpb24Kd2hlbiBhdmFpbGFibGUuCgpUaGVyZSBkb2VzIG5vdCBhcHBlYXIgdG8gYmUg
YW55IGV4aXN0aW5nIG1lY2hhbmlzbSBmb3IgdGhlIGdlbmVyaWMKbGliL211bGRpMy5jIGNv
ZGUgdG8gcGljayB1cCBhbiBleHRlcm5hbCBhcmNoIGRlZmluaXRpb24gb2YgdW11bF9wcG1t
KCkuCkNyZWF0ZSBhbiBhcmNoIHNwZWNpZmljIGxpYmdjYy5oIHRoYXQgY2FuIG9wdGlvbmFs
bHkgYmUgaW5jbHVkZWQgYnkKdGhlIHN5c3RlbSBpbmNsdWRlL2xpbnV4L2xpYmdjYy5oIHRv
IGFsbG93IGZvciB0aGlzLgoKU29tZXdoYXQgb2RkbHkgdGhlcmUgaXMgYWxzbyBhIHNpbWls
YXIgZGVmaW5pdGlvbiBvZiB1bXVsX3BwbW0oKSBpbgp0aGUgbm9uLWFyY2hpdGVjdHVyZSBj
b2RlIGluIGxpYi9jcnlwdG8vbXBpL2xvbmdsb25nLmggZm9yIGEgd2lkZSByYW5nZQpvciBt
YWNoaW5lcy4gSXRzIHByZXNlbmNlIGVuZHMgdXAgY29tcGxpY2F0aW5nIHRoZSBpbmNsdWRl
IHNldHVwIGFuZAptZWFucyBub3QgYmVpbmcgYWJsZSB0byB1c2Ugc29tZXRoaW5nIGxpa2Ug
Y29tcGlsZXIuaCBpbnN0ZWFkLgoKU2lnbmVkLW9mZi1ieTogR3JlZyBVbmdlcmVyIDxnZXJn
QGxpbnV4LW02OGsub3JnPgotLS0KIGFyY2gvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8
ICA4ICsrKwogYXJjaC9tNjhrL0tjb25maWcgICAgICAgICAgICAgIHwgIDIgKwogYXJjaC9t
NjhrL2luY2x1ZGUvYXNtL2xpYmdjYy5oIHwgMjAgKysrKysrKwogYXJjaC9tNjhrL2xpYi9N
YWtlZmlsZSAgICAgICAgIHwgIDIgKy0KIGFyY2gvbTY4ay9saWIvbXVsZGkzLmMgICAgICAg
ICB8IDk3IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGluY2x1ZGUvbGlu
dXgvbGliZ2NjLmggICAgICAgICB8ICA0ICsrCiA2IGZpbGVzIGNoYW5nZWQsIDM1IGluc2Vy
dGlvbnMoKyksIDk4IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvbTY4
ay9pbmNsdWRlL2FzbS9saWJnY2MuaAogZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvbTY4ay9s
aWIvbXVsZGkzLmMKCmRpZmYgLS1naXQgYS9hcmNoL0tjb25maWcgYi9hcmNoL0tjb25maWcK
aW5kZXggNjY4MmIyYTUzZTM0Li5iOGE0ZmYzNjU1ODIgMTAwNjQ0Ci0tLSBhL2FyY2gvS2Nv
bmZpZworKysgYi9hcmNoL0tjb25maWcKQEAgLTE1MjYsNiArMTUyNiwxNCBAQCBjb25maWcg
SEFWRV9BUkNIX0NPTVBJTEVSX0gKIAkgIGxpbnV4L2NvbXBpbGVyLSouaCBpbiBvcmRlciB0
byBvdmVycmlkZSBtYWNybyBkZWZpbml0aW9ucyB0aGF0IHRob3NlCiAJICBoZWFkZXJzIGdl
bmVyYWxseSBwcm92aWRlLgogCitjb25maWcgSEFWRV9BUkNIX0xJQkdDQ19ICisJYm9vbAor
CWhlbHAKKwkgIEFuIGFyY2hpdGVjdHVyZSBjYW4gc2VsZWN0IHRoaXMgaWYgaXQgcHJvdmlk
ZXMgYW4KKwkgIGFzbS9saWJnY2MuaCBoZWFkZXIgdGhhdCBzaG91bGQgYmUgaW5jbHVkZWQg
YWZ0ZXIKKwkgIGxpbnV4L2xpYmdjYy5oIGluIG9yZGVyIHRvIG92ZXJyaWRlIG1hY3JvIGRl
ZmluaXRpb25zIHRoYXQKKwkgIGhlYWRlciBnZW5lcmFsbHkgcHJvdmlkZXMuCisKIGNvbmZp
ZyBIQVZFX0FSQ0hfUFJFTDMyX1JFTE9DQVRJT05TCiAJYm9vbAogCWhlbHAKZGlmZiAtLWdp
dCBhL2FyY2gvbTY4ay9LY29uZmlnIGIvYXJjaC9tNjhrL0tjb25maWcKaW5kZXggN2M0Zjdi
Y2M4OWQ3Li5iMmVkMDMwOGMwZWEgMTAwNjQ0Ci0tLSBhL2FyY2gvbTY4ay9LY29uZmlnCisr
KyBiL2FyY2gvbTY4ay9LY29uZmlnCkBAIC0yMyw3ICsyMyw5IEBAIGNvbmZpZyBNNjhLCiAJ
c2VsZWN0IEdFTkVSSUNfTElCX0FTSExESTMKIAlzZWxlY3QgR0VORVJJQ19MSUJfQVNIUkRJ
MwogCXNlbGVjdCBHRU5FUklDX0xJQl9MU0hSREkzCisJc2VsZWN0IEdFTkVSSUNfTElCX01V
TERJMwogCXNlbGVjdCBIQVNfSU9QT1JUIGlmIFBDSSB8fCBJU0EgfHwgQVRBUklfUk9NX0lT
QQorCXNlbGVjdCBIQVZFX0FSQ0hfTElCR0NDX0gKIAlzZWxlY3QgSEFWRV9BUkNIX1NFQ0NP
TVAKIAlzZWxlY3QgSEFWRV9BUkNIX1NFQ0NPTVBfRklMVEVSCiAJc2VsZWN0IEhBVkVfQVNN
X01PRFZFUlNJT05TCmRpZmYgLS1naXQgYS9hcmNoL202OGsvaW5jbHVkZS9hc20vbGliZ2Nj
LmggYi9hcmNoL202OGsvaW5jbHVkZS9hc20vbGliZ2NjLmgKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMDAwMDAwLi4xY2NlNmQxMzBkODAKLS0tIC9kZXYvbnVsbAorKysg
Yi9hcmNoL202OGsvaW5jbHVkZS9hc20vbGliZ2NjLmgKQEAgLTAsMCArMSwyMCBAQAorLyog
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8KKyNpZm5kZWYgX19BU01fTTY4
S19MSUJHQ0NfSAorI2RlZmluZSBfX0FTTV9NNjhLX0xJQkdDQ19ICisKKyNpZm5kZWYgQ09O
RklHX0NQVV9IQVNfTk9fTVVMRElWNjQKKy8qCisgKiBGb3IgdGhvc2UgNjhLIENQVXMgdGhh
dCBzdXBwb3J0IDY0Yml0IG11bHRpcGx5IGRlZmluZSB1bXVsX3BwbSgpCisgKiBmb3IgdGhl
IGNvbW1vbiBtdWxkaTMgbGliZ2NjIGhlbHBlciBmdW5jdGlvbiAoaW4gbGliL211bGRpMy5j
KS4KKyAqIENQVXMgdGhhdCBkb24ndCBoYXZlIGl0IChsaWtlIHRoZSBvcmlnaW5hbCA2ODAw
MCBhbmQgQ29sZEZpcmUpCisgKiB3aWxsIGZhbGxiYWNrIHRvIHVzaW5nIHRoZSBDLWNvZGVk
IHZlcnNpb24gb2YgdW11bF9wcG1tKCkuCisgKi8KKyNkZWZpbmUgdW11bF9wcG1tKHcxLCB3
MCwgdSwgdikJCQkJXAorCV9fYXNtX18gKCJtdWx1JS5sICUzLCUxOiUwIgkJCVwKKwkJIDog
Ij1kIiAoKHVuc2lnbmVkIGxvbmcpKHcwKSksCQlcCisJCSAgICI9ZCIgKCh1bnNpZ25lZCBs
b25nKSh3MSkpCQlcCisJCSA6ICIlMCIgKCh1bnNpZ25lZCBsb25nKSh1KSksCQlcCisJCSAg
ICJkbWkiICgodW5zaWduZWQgbG9uZykodikpKQorI2VuZGlmIC8qICFDT05GSUdfQ1BVX0hB
U19OT19NVUxESVY2NCAqLworCisjZW5kaWYgLyogX19BU01fTTY4S19MSUJHQ0NfSCAqLwpk
aWZmIC0tZ2l0IGEvYXJjaC9tNjhrL2xpYi9NYWtlZmlsZSBiL2FyY2gvbTY4ay9saWIvTWFr
ZWZpbGUKaW5kZXggOTE1ODY4OGU2Y2M2Li4xNTI3OGE5NTI1OWUgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvbTY4ay9saWIvTWFrZWZpbGUKKysrIGIvYXJjaC9tNjhrL2xpYi9NYWtlZmlsZQpAQCAt
NCw3ICs0LDcgQEAKICMgTWFrZWZpbGUgZm9yIG02OGstc3BlY2lmaWMgbGlicmFyeSBmaWxl
cy4uCiAjCiAKLWxpYi15CTo9IG11bGRpMy5vIG1lbWNweS5vIG1lbXNldC5vIG1lbW1vdmUu
bworbGliLXkJOj0gbWVtY3B5Lm8gbWVtc2V0Lm8gbWVtbW92ZS5vCiAKIGxpYi0kKENPTkZJ
R19NTVUpICs9IHVhY2Nlc3MubwogbGliLSQoQ09ORklHX0NQVV9IQVNfTk9fTVVMRElWNjQp
ICs9IG11bHNpMy5vIGRpdnNpMy5vIHVkaXZzaTMubwpkaWZmIC0tZ2l0IGEvYXJjaC9tNjhr
L2xpYi9tdWxkaTMuYyBiL2FyY2gvbTY4ay9saWIvbXVsZGkzLmMKZGVsZXRlZCBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDUwMTJhOWIyMThjNy4uMDAwMDAwMDAwMDAwCi0tLSBhL2FyY2gv
bTY4ay9saWIvbXVsZGkzLmMKKysrIC9kZXYvbnVsbApAQCAtMSw5NyArMCwwIEBACi0vKiBt
dWxkaTMuYyBleHRyYWN0ZWQgZnJvbSBnY2MtMi43LjIuMy9saWJnY2MyLmMgYW5kIAotCQkJ
ICAgZ2NjLTIuNy4yLjMvbG9uZ2xvbmcuaCB3aGljaCBpczogKi8KLS8qIENvcHlyaWdodCAo
QykgMTk4OSwgMTk5MiwgMTk5MywgMTk5NCwgMTk5NSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24sIEluYy4KLQotVGhpcyBmaWxlIGlzIHBhcnQgb2YgR05VIENDLgotCi1HTlUgQ0MgaXMg
ZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQot
aXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBh
cyBwdWJsaXNoZWQgYnkKLXRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2
ZXJzaW9uIDIsIG9yIChhdCB5b3VyIG9wdGlvbikKLWFueSBsYXRlciB2ZXJzaW9uLgotCi1H
TlUgQ0MgaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1
bCwKLWJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVk
IHdhcnJhbnR5IG9mCi1NRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNV
TEFSIFBVUlBPU0UuICBTZWUgdGhlCi1HTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3Ig
bW9yZSBkZXRhaWxzLiAqLwotCi0jaW5jbHVkZSA8bGludXgvY29tcGlsZXIuaD4KLSNpbmNs
dWRlIDxsaW51eC9leHBvcnQuaD4KLSNpbmNsdWRlIDxsaW51eC9saWJnY2MuaD4KLQotI2lm
ZGVmIENPTkZJR19DUFVfSEFTX05PX01VTERJVjY0Ci0KLSNkZWZpbmUgU0lfVFlQRV9TSVpF
IDMyCi0jZGVmaW5lIF9fQklUUzQgKFNJX1RZUEVfU0laRSAvIDQpCi0jZGVmaW5lIF9fbGxf
QiAoMUwgPDwgKFNJX1RZUEVfU0laRSAvIDIpKQotI2RlZmluZSBfX2xsX2xvd3BhcnQodCkg
KChVU0l0eXBlKSAodCkgJSBfX2xsX0IpCi0jZGVmaW5lIF9fbGxfaGlnaHBhcnQodCkgKChV
U0l0eXBlKSAodCkgLyBfX2xsX0IpCi0KLSNkZWZpbmUgdW11bF9wcG1tKHcxLCB3MCwgdSwg
dikJCQkJCQlcCi0gIGRvIHsJCQkJCQkJCQlcCi0gICAgVVNJdHlwZSBfX3gwLCBfX3gxLCBf
X3gyLCBfX3gzOwkJCQkJXAotICAgIFVTSXR5cGUgX191bCwgX192bCwgX191aCwgX192aDsJ
CQkJCVwKLQkJCQkJCQkJCVwKLSAgICBfX3VsID0gX19sbF9sb3dwYXJ0ICh1KTsJCQkJCQlc
Ci0gICAgX191aCA9IF9fbGxfaGlnaHBhcnQgKHUpOwkJCQkJCVwKLSAgICBfX3ZsID0gX19s
bF9sb3dwYXJ0ICh2KTsJCQkJCQlcCi0gICAgX192aCA9IF9fbGxfaGlnaHBhcnQgKHYpOwkJ
CQkJCVwKLQkJCQkJCQkJCVwKLSAgICBfX3gwID0gKFVTSXR5cGUpIF9fdWwgKiBfX3ZsOwkJ
CQkJXAotICAgIF9feDEgPSAoVVNJdHlwZSkgX191bCAqIF9fdmg7CQkJCQlcCi0gICAgX194
MiA9IChVU0l0eXBlKSBfX3VoICogX192bDsJCQkJCVwKLSAgICBfX3gzID0gKFVTSXR5cGUp
IF9fdWggKiBfX3ZoOwkJCQkJXAotCQkJCQkJCQkJXAotICAgIF9feDEgKz0gX19sbF9oaWdo
cGFydCAoX194MCk7LyogdGhpcyBjYW4ndCBnaXZlIGNhcnJ5ICovCQlcCi0gICAgX194MSAr
PSBfX3gyOwkJLyogYnV0IHRoaXMgaW5kZWVkIGNhbiAqLwkJXAotICAgIGlmIChfX3gxIDwg
X194MikJCS8qIGRpZCB3ZSBnZXQgaXQ/ICovCQkJXAotICAgICAgX194MyArPSBfX2xsX0I7
CQkvKiB5ZXMsIGFkZCBpdCBpbiB0aGUgcHJvcGVyIHBvcy4gKi8JXAotCQkJCQkJCQkJXAot
ICAgICh3MSkgPSBfX3gzICsgX19sbF9oaWdocGFydCAoX194MSk7CQkJCQlcCi0gICAgKHcw
KSA9IF9fbGxfbG93cGFydCAoX194MSkgKiBfX2xsX0IgKyBfX2xsX2xvd3BhcnQgKF9feDAp
OwkJXAotICB9IHdoaWxlICgwKQotCi0jZWxzZQotCi0jZGVmaW5lIHVtdWxfcHBtbSh3MSwg
dzAsIHUsIHYpIFwKLSAgX19hc21fXyAoIm11bHUlLmwgJTMsJTE6JTAiCQkJCQkJXAotICAg
ICAgICAgICA6ICI9ZCIgKChVU0l0eXBlKSh3MCkpLAkJCQkJXAotICAgICAgICAgICAgICI9
ZCIgKChVU0l0eXBlKSh3MSkpCQkJCQlcCi0gICAgICAgICAgIDogIiUwIiAoKFVTSXR5cGUp
KHUpKSwJCQkJCVwKLSAgICAgICAgICAgICAiZG1pIiAoKFVTSXR5cGUpKHYpKSkKLQotI2Vu
ZGlmCi0KLSNkZWZpbmUgX191bXVsc2lkaTModSwgdikgXAotICAoe0RJdW5pb24gX193OwkJ
CQkJCQlcCi0gICAgdW11bF9wcG1tIChfX3cucy5oaWdoLCBfX3cucy5sb3csIHUsIHYpOwkJ
CQlcCi0gICAgX193LmxsOyB9KQotCi10eXBlZGVmIAkgaW50IFNJdHlwZQlfX21vZGUoU0kp
OwotdHlwZWRlZiB1bnNpZ25lZCBpbnQgVVNJdHlwZQlfX21vZGUoU0kpOwotdHlwZWRlZgkJ
IGludCBESXR5cGUJX19tb2RlKERJKTsKLXR5cGVkZWYgaW50IHdvcmRfdHlwZSAgICAgICAg
ICAgX19tb2RlKF9fd29yZF9fKTsKLQotc3RydWN0IERJc3RydWN0IHtTSXR5cGUgaGlnaCwg
bG93O307Ci0KLXR5cGVkZWYgdW5pb24KLXsKLSAgc3RydWN0IERJc3RydWN0IHM7Ci0gIERJ
dHlwZSBsbDsKLX0gREl1bmlvbjsKLQotREl0eXBlCi1fX211bGRpMyAoREl0eXBlIHUsIERJ
dHlwZSB2KQotewotICBESXVuaW9uIHc7Ci0gIERJdW5pb24gdXUsIHZ2OwotCi0gIHV1Lmxs
ID0gdTsKLSAgdnYubGwgPSB2OwotCi0gIHcubGwgPSBfX3VtdWxzaWRpMyAodXUucy5sb3cs
IHZ2LnMubG93KTsKLSAgdy5zLmhpZ2ggKz0gKChVU0l0eXBlKSB1dS5zLmxvdyAqIChVU0l0
eXBlKSB2di5zLmhpZ2gKLQkgICAgICAgKyAoVVNJdHlwZSkgdXUucy5oaWdoICogKFVTSXR5
cGUpIHZ2LnMubG93KTsKLQotICByZXR1cm4gdy5sbDsKLX0KLUVYUE9SVF9TWU1CT0woX19t
dWxkaTMpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9saWJnY2MuaCBiL2luY2x1ZGUv
bGludXgvbGliZ2NjLmgKaW5kZXggZmMzODhkYTZhMDI3Li4wZDY4ZjlkNmE2YTcgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvbGludXgvbGliZ2NjLmgKKysrIGIvaW5jbHVkZS9saW51eC9saWJn
Y2MuaApAQCAtMzQsNCArMzQsOCBAQCBsb25nIGxvbmcgbm90cmFjZSBfX2xzaHJkaTMobG9u
ZyBsb25nIHUsIHdvcmRfdHlwZSBiKTsKIGxvbmcgbG9uZyBub3RyYWNlIF9fbXVsZGkzKGxv
bmcgbG9uZyB1LCBsb25nIGxvbmcgdik7CiB3b3JkX3R5cGUgbm90cmFjZSBfX3VjbXBkaTIo
dW5zaWduZWQgbG9uZyBsb25nIGEsIHVuc2lnbmVkIGxvbmcgbG9uZyBiKTsKIAorI2lmZGVm
IENPTkZJR19IQVZFX0FSQ0hfTElCR0NDX0gKKyNpbmNsdWRlIDxhc20vbGliZ2NjLmg+Cisj
ZW5kaWYKKwogI2VuZGlmIC8qIF9fQVNNX0xJQkdDQ19IICovCi0tIAoyLjI1LjEKCg==

--------------ynBQ5orTojtKmtqZQOw1ViC4--

